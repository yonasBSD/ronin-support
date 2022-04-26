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

require 'ronin/support/network/mixins/ssl'

module Ronin
  module Support
    module Network
      module Mixins
        #
        # Provides helper methods for communicating with TLS-enabled services.
        #
        # @since 1.0.0
        #
        module TLS
          include Mixins::SSL

          #
          # Creates a new TLS Context.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {SSL#ssl_context}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @option kwargs [String] :certs
          #   Path to the CA certificate file or directory.
          #
          # @return [OpenSSL::SSL::SSLContext]
          #   The newly created SSL Context.
          #
          # @api semipublic
          #
          def tls_context(version: 1.2, **kwargs)
            ssl_context(version: version, **kwargs)
          end

          #
          # Initiates an SSL session with an existing TCP socket.
          #
          # @param [TCPSocket] socket
          #   The existing TCP socket.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_context}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @return [OpenSSL::SSL::SSLSocket]
          #   the new SSL Socket.
          #
          # @api public
          #
          def tls_socket(socket, version: 1.2, **kwargs)
            ssl_socket(socket,version: version, **kwargs)
          end

          #
          # Tests whether a remote SSLed TCP port is open.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_session}.
          #
          # @option kwargs [Integer] :timeout (5)
          #   The maximum time to attempt connecting.
          #
          # @option options [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option options [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option options [String] :key
          #   The path to the SSL `.key` file.
          #
          # @return [Boolean, nil]
          #   Specifies whether the remote SSLed TCP port is open.
          #   If the connection was not accepted, `nil` will be returned.
          #
          # @example
          #   ssl_open?('www.bankofamerica.com',443)
          #
          # @example Using a timeout:
          #   ssl_open?('example.com',80, timeout: 5)
          #   # => nil
          #
          # @api public
          #
          def tls_open?(host,port,local_host=nil,local_port=nil, version: 1.2,
                                                                 **kwargs)
            ssl_open?(host,port,local_host,local_port, version: version, **kwargs)
          end

          #
          # Establishes a SSL connection.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_socket}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @yield [ssl_socket]
          #   The given block will be passed the new SSL Socket.
          #
          # @yieldparam [OpenSSL::SSL::SSLSocket] ssl_socket
          #   The new SSL Socket.
          #
          # @return [OpenSSL::SSL::SSLSocket]
          #   the new SSL Socket.
          #
          # @example
          #   socket = ssl_connect('twitter.com',443)
          #
          # @see http://rubydoc.info/stdlib/openssl/OpenSSL/SSL/SSLSocket
          #
          # @api public
          #
          def tls_connect(host,port,local_host=nil,local_port=nil, version: 1.2,
                                                                   **kwargs,
                                                                   &block)
            ssl_connect(host,port,local_host,local_port, version: version,
                                                         **kwargs,
                                                         &block)
          end

          #
          # Creates a new SSL connection and sends the given data.
          #
          # @param [String] data
          #   The data to send through the connection.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_connect}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @yield [ssl_socket]
          #   The given block will be passed the newly created SSL Socket.
          #
          # @yieldparam [OpenSSL::SSL::SSLSocket] ssl_socket
          #   The newly created SSL Socket.
          #
          # @api public
          #
          def tls_connect_and_send(data,host,port,local_host=nil,local_port=nil,version: 1.2, **kwargs,&block)
            ssl_connect_and_send(data,host,port,local_host=nil,local_port=nil,version: version, **kwargs,&block)
          end

          #
          # Creates a new temporary SSL connection.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_session}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @yield [ssl_socket]
          #   The given block will be passed the temporary SSL Socket.
          #
          # @yieldparam [OpenSSL::SSL::SSLSocket] ssl_socket
          #   The temporary SSL Socket.
          #
          # @return [nil]
          #
          # @example
          #   ssl_session('twitter.com',443) do |sock|
          #     sock.write("GET / HTTP/1.1\n\r\n\r")
          #
          #     sock.each_line { |line| puts line }
          #   end
          #
          # @see http://rubydoc.info/stdlib/openssl/OpenSSL/SSL/SSLSocket
          #
          # @api public
          #
          def tls_session(host,port,local_host=nil,local_port=nil, version: 1.2, **kwargs,&block)
            ssl_session(host,port,local_host=nil,local_port=nil, version: version, **kwargs,&block)
          end

          #
          # Reads the banner from the service running on the given host and
          # port.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_session}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @yield [banner]
          #   If a block is given, it will be passed the grabbed banner.
          #
          # @yieldparam [String] banner
          #   The grabbed banner.
          #
          # @return [String]
          #   The grabbed banner.
          #
          # @example
          #   ssl_banner('smtp.gmail.com',465)
          #   # => "220 mx.google.com ESMTP c20sm3096959rvf.1"
          #
          # @api public
          #
          def tls_banner(host,port,local_host=nil,local_port=nil, version: 1.2, **kwargs,&block)
            ssl_banner(host,port,local_host,local_port, version: version, **kwargs,&block)
          end

          #
          # Connects to a specified host and port, sends the given data and then
          # closes the connection.
          #
          # @param [String] data
          #   The data to send through the connection.
          #
          # @param [String] host
          #   The host to connect to.
          #
          # @param [Integer] port
          #   The port to connect to.
          #
          # @param [String] local_host
          #   The local host to bind to.
          #
          # @param [Integer] local_port
          #   The local port to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_session}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key
          #   The path to the SSL `.key` file.
          #
          # @return [true]
          #   The data was successfully sent.
          #
          # @example
          #   buffer = "GET /#{'A' * 4096}\n\r"
          #   ssl_send(buffer,'victim.com',443)
          #   # => true
          #
          # @api public
          #
          def tls_send(data,host,port,local_host=nil,local_port=nil, version: 1.2, **kwargs)
            ssl_send(data,host,port,local_host,local_port, version: version, **kwargs)
          end

          #
          # Accepts an SSL session from an existing TCP socket.
          #
          # @param [TCPSocket] socket
          #   The existing TCP socket.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_socket}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert (DEFAULT_CERT_FILE)
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key (DEFAULT_KEY_FILE)
          #   The path to the SSL `.key` file.
          #
          # @return [OpenSSL::SSL::SSLSocket]
          #   the new SSL Socket.
          #
          # @api public
          #
          def tls_server_socket(socket, version: 1.2,
                                        **kwargs)
            ssl_server_socket(socket, version: version, **kwargs)
          end

          #
          # Creates a new SSL socket listening on a given host and port,
          # accepting clients in a loop.
          #
          # @param [Integer] port
          #   The local port to listen on.
          #
          # @param [String] host
          #   The host to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_server_socket}.
          #
          # @option kwargs [Integer] :backlog (5)
          #   The maximum backlog of pending connections.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert (DEFAULT_CERT_FILE)
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key (DEFAULT_KEY_FILE)
          #   The path to the SSL `.key` file.
          #
          # @yield [client]
          #   The given block will be passed the newly connected client.
          #   After the block has finished, the client will be closed.
          #
          # @yieldparam [OpenSSL::SSL::SSLSocket] client
          #   A newly connected client.
          #
          # @return [nil]
          #
          # @example
          #   # $ openssl genrsa -out ssl.key 1024
          #   # $ openssl req -new -key ssl.key -x509 -days 3653 -out ssl.crt
          #   # $ cat ssl.key ssl.crt > ssl.pem
          #   # $ chmod 600 ssl.key ssl.pem
          #   ssl_server_loop(port: 1337, cert: 'ssl.crt', key: 'ssl.key') do |sock|
          #     sock.puts 'lol'
          #   end
          #
          # @api public
          #
          def tls_server_loop(port=nil,host=nil, version: 1.2,
                                                 **kwargs,
                                                 &block)
            ssl_server_loop(port,host, version: 1.2, **kwargs, &block)
          end

          #
          # Creates a new SSL socket listening on a given host and port,
          # accepts only one client and then stops listening.
          #
          # @param [Integer] port
          #   The local port to listen on.
          #
          # @param [String] host
          #   The host to bind to.
          #
          # @param [1, 1.1, 1.2, String, Symbol, nil] version
          #   The TLS version to use.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments for {#ssl_server_socket}.
          #
          # @option kwargs [Symbol, Boolean] :verify
          #   Specifies whether to verify the SSL certificate.
          #   May be one of the following:
          #
          #   * `:none`
          #   * `:peer`
          #   * `:fail_if_no_peer_cert`
          #   * `:client_once`
          #
          # @option kwargs [String] :cert (DEFAULT_CERT_FILE)
          #   The path to the SSL `.crt` file.
          #
          # @option kwargs [String] :key (DEFAULT_KEY_FILE)
          #   The path to the SSL `.key` file.
          #
          # @example
          #   ssl_accept(1337) do |client|
          #     client.puts 'lol'
          #   end
          #
          # @yield [client]
          #   The given block will be passed the newly connected client.
          #   After the block has finished, both the client and the server will
          #   be closed.
          #
          # @yieldparam [OpenSSL::SSL::SSLSocket] client
          #   The newly connected client.
          #
          # @return [nil]
          #
          # @example
          #   # $ openssl genrsa -out ssl.key 1024
          #   # $ openssl req -new -key ssl.key -x509 -days 3653 -out ssl.crt
          #   # $ cat ssl.key ssl.crt > ssl.pem
          #   # $ chmod 600 ssl.key ssl.pem
          #   ssl_accept(port: 1337, cert: 'ssl.crt', key: 'ssl.key') do |client|
          #     client.puts 'lol'
          #   end
          #
          # @api public
          #
          def tls_accept(port=nil,host=nil, version: 1.2, **kwargs, &block)
            ssl_accept(port,host, version: version, **kwargs, &block)
          end
        end
      end
    end
  end
end
