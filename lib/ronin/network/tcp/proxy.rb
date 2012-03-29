#
# Copyright (c) 2006-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin Support.
#
# Ronin Support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin Support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Ronin Support.  If not, see <http://www.gnu.org/licenses/>.
#

require 'ronin/network/proxy'

require 'socket'

module Ronin
  module Network
    module TCP
      #
      # The TCP Proxy allows for inspecting and manipulating TCP protocols.
      #
      # ## Callbacks
      #
      # In addition to the events supported by the {Network::Proxy Proxy}
      # base class, the TCP Proxy also supports the following callbacks.
      #
      # ### client_connect
      #
      # When a client connects to the proxy:
      #
      #     on(:client_connect) do |client|
      #       puts "[connected] #{client.remote_address.ip_address}:#{client.remote_address.ip_port}"
      #     end
      #
      # ### client_disconnect
      #
      # When a client disconnects from the proxy:
      #
      #     on(:client_disconnect) do |client,server|
      #       puts "[disconnected] #{client.remote_address.ip_address}:#{client.remote_address.ip_port}"
      #     end
      #
      # ### server_connect
      #
      # When the server accetps a connection from the proxy:
      #
      #     proxy.on(:server_connect) do |client,server|
      #       puts "[connected] #{proxy}"
      #     end
      #
      # ### server_disconnect
      #
      # When the server closes a connection from the proxy.
      #
      #     on(:server_disconnect) do |client,server|
      #       puts "[disconnected] #{proxy}"
      #     end
      #
      # ### connect
      #
      # Alias for `server_connect`.
      #
      # ### disconnect
      #
      # Alias for `client_disconnect`.
      #
      class Proxy < Network::Proxy

        #
        # Creates a new TCP Proxy.
        #
        def initialize(proxy,server)
          super(proxy,server)

          @callbacks[:client_connect]    = []
          @callbacks[:client_disconnect] = []
          @callbacks[:server_connect]    = []
          @callbacks[:server_disconnect] = []

          yield self if block_given?
        end

        #
        # Opens the proxy.
        #
        def open
          @proxy_socket = TCPServer.new(@proxy_host,@proxy_port)
        end

        #
        # Polls the connections for data.
        #
        def poll
          client_sockets = @connections.keys
          server_sockets = @connections.values

          sockets = [@proxy_socket] + client_sockets + server_sockets

          readable, writtable, errors = IO.select(sockets,nil,sockets)

          (errors & client_sockets).each do |client_socket|
            server_socket = @connections[client_socket]

            client_disconnect(client_socket,server_socket)
          end

          (errors & server_sockets).each do |server_socket|
            client_socket = @connections.key(server_socket)

            server_disconnect(client_socket,server_socket)
          end

          (readable & client_sockets).each do |client_socket|
            server_socket = @connections[client_socket]
            data = recv(client_socket)

            client_data(client_socket,server_socket,data)
          end

          (readable & server_sockets).each do |server_socket|
            client_socket = @connections.key(server_socket)
            data = recv(server_socket)

            server_data(client_socket,server_socket,data)
          end

          if readable.include?(@proxy_socket)
            client_socket = @proxy_socket.accept

            client_connect(client_socket)
          end
        end

        #
        # Sends data to a connection.
        #
        # @param [TCPSocket] connection
        # 
        # @param [String] data
        #
        def send(connection,data)
          connection.send(data,0)
        end

        #
        # Receives data from a connection.
        #
        # @param [TCPSocket] connection
        #
        # @return [String, nil]
        #   The received data.
        #
        def recv(connection)
          connection.recv(@buffer_size)
        end

        #
        # Registers a callback for an event.
        #
        # @param [Symbol] event
        #   The event to attach the callback to.
        #
        # @yield [(client), (client,server), (client,server,data)]
        #   The callback will be passed the client connection, the server
        #   connection and the data.
        #
        # @yieldparam [TCPSocket] client
        #   The connection from the client to the proxy.
        #
        # @yieldparam [TCPSocket] server
        #   The connection from the proxy to the server.
        #
        # @yieldparam [String] data
        #   The data being sent through the proxy.
        #
        # @example Registers a callback for `client_connect`:
        #   proxy.on(:client_connect) do |client|
        #     proxy.send(client,"HELLO")
        #   end
        #
        def on(event,&block)
          case event
          when :connect
            @callbacks[:server_connect] << block
          when :disconnect
            @callbacks[:client_disconnect] << block
          else
            super(event,&block)
          end
        end

        #
        # Triggers the `client_connect` event.
        #
        # @param [connection] client_connection
        #   The new connection from a client to the proxy.
        #
        def client_connect(client_connection)
          callback(:client_connect,client_connection) do
            server_connect(client_connection)
          end
        end

        #
        # Triggers the `client_disconnect` event.
        #
        # @param [connection] client_connection
        #   The connection from a client to the proxy.
        #
        # @param [connection] server_connection
        #   The connection from the proxy to the server.
        #
        def client_disconnect(client_connection,server_connection)
          callback(:client_disconnect,client_connection,server_connection) do
            close_connection(client_connection,server_connection)
          end
        end

        #
        # Triggers the `server_connect` event.
        #
        # @param [connection] client_connection
        #   The connection from a client to the proxy.
        #
        def server_connect(client_connection)
          server_connection = new_server_connection

          callback(:server_connect,client_connection,server_connection) do
            @connections[client_connection] = server_connection
          end
        end

        #
        # Triggers the `server_disconnect` event.
        #
        # @param [connection] client_connection
        #   The connection from a client to the proxy.
        #
        # @param [connection] server_connection
        #   The connection from the proxy to the server.
        #
        def server_disconnect(client_connection,server_connection)
          callback(:server_disconnect,client_connection,server_connection) do
            close_connection(client_connection)
          end
        end

        protected

        #
        # Creates a new connection to the server.
        #
        # @return [TCPSocket]
        #   A new connection.
        #
        def new_server_connection
          TCPSocket.new(@server_host,@server_port)
        end

        #
        # Closes a connection from the client.
        #
        # @param [TCPSocket] socket
        #   The connection from the client.
        #
        def close_client_connection(socket)
          socket.close
        end

        #
        # Closes a connection to the server.
        #
        # @param [TCPSocket] socket
        #   The connection to the server.
        #
        def close_server_connection(socket)
          socket.close
        end

        #
        # Closes the TCP proxy.
        #
        def close_proxy
          @proxy_socket.close
        end

      end
    end
  end
end
