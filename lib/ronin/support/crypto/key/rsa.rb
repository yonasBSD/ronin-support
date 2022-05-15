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

require 'ronin/support/crypto/key/methods'
require 'ronin/support/crypto/openssl'

module Ronin
  module Support
    module Crypto
      module Key
        #
        # Represents an RSA key.
        #
        # @see https://rubydoc.info/stdlib/openssl/OpenSSL/PKey/RSA.html
        #
        # @since 1.0.0
        #
        # @api public
        #
        class RSA < OpenSSL::PKey::RSA

          include Methods

          #
          # Generates a new random RSA key.
          #
          # @param [Integer] key_size
          #   The size of the key in bits.
          #
          # @return [RSA]
          #   The newly generated key.
          #
          def self.random(key_size=1024)
            # HACK: openssl-3.0.0 will return an OpenSSL::PKey::RSA instance,
            # even though we subclassed OpenSSL::PKey::RSA.
            new(generate(key_size))
          end

          #
          # The `n` variable for the RSA key.
          #
          # @return [OpenSSL::BN]
          #
          # @see https://rubydoc.info/stdlib/openssl/OpenSSL/BN
          #
          def n
            super()
          end

          #
          # The `e` variable for the RSA key.
          #
          # @return [OpenSSL::BN]
          #
          # @see https://rubydoc.info/stdlib/openssl/OpenSSL/BN
          #
          def e
            super()
          end

          #
          # The `d` variable for the RSA key.
          #
          # @return [OpenSSL::BN]
          #
          # @see https://rubydoc.info/stdlib/openssl/OpenSSL/BN
          #
          def d
            super()
          end

          #
          # The size of the RSA key in bits.
          #
          # @return [Integer]
          #   The key size in bits.
          #
          def size
            n.num_bits
          end

          # Mapping of padding names to pdding constants.
          #
          # @api private
          PADDINGS = {
            pkcs1_oaep: PKCS1_OAEP_PADDING,
            pkcs1:      PKCS1_PADDING,
            sslv23:     SSLV23_PADDING,

            nil      => NO_PADDING,
            false    => NO_PADDING
          }

          #
          # Encrypts data using the public key.
          #
          # @param [String] data
          #   The data to encrypt.
          #
          # @param [:pkcs1_oaep, :pkcs1, :sslv23, nil, false] padding
          #   Optional padding mode. `nil` and `false` will disable padding.
          #
          # @return [String]
          #   The encrypted data.
          #
          # @example
          #   rsa = Crypto::Key::RSA.load_file('key.pem')
          #   rsa.encrypt("top secret", padding: :pkcs1_oaep)
          #   # => "i;k\x89\xE9\x92\xA5\xAB\xBAc\xC6;\r\xB7\x18W\x11\x02\xCBf.\xC2\x87\xDF\xDD[|\xF0\x97\x15\xC6\xCF\xCD\x93\x1C\x11S&L\x89\xE6\xCA\xC9\xAD\xAD\x1F\xE6\x8D\x86\xF3$\x8BfS(3\x9F\x7F\xEFZ \xB7\xDC{f\xF1\xB7-\x18\x94\xB8}\x93%,{X\x85\xBD(\xBD\xAD\x00,O\xAC\xECJ}\x99\xC7\xE2\xB6\x11\x9D\xDF\x12\xA5\x8F|\xF8\xC3Q\xDA\x95\x12\xEFH\xFFt\xCD\x854jJ\xE9\xE7\xC4\xDD|\xD4}w\xDAJ8\xAE\x17"
          #
          def encrypt(data, padding: :pkcs1)
            padding_const = PADDINGS.fetch(padding) do
              raise(ArgumentError,"padding must be #{PADDINGS.keys.map(&:inspect).join(', ')}: #{padding.inspect}")
            end

            public_encrypt(data,padding_const)
          end

          #
          # Decrypts data using the private key.
          #
          # @param [String] data
          #   The data to decrypt.
          #
          # @param [:pkcs1_oaep, :pkcs1, :sslv23, nil, false] padding
          #   Optional padding mode. `nil` and `false` will disable padding.
          #
          # @return [String]
          #   The decrypted data.
          #
          # @example
          #   encrypted = "i;k\x89\xE9\x92\xA5\xAB\xBAc\xC6;\r\xB7\x18W\x11\x02\xCBf.\xC2\x87\xDF\xDD[|\xF0\x97\x15\xC6\xCF\xCD\x93\x1C\x11S&L\x89\xE6\xCA\xC9\xAD\xAD\x1F\xE6\x8D\x86\xF3$\x8BfS(3\x9F\x7F\xEFZ \xB7\xDC{f\xF1\xB7-\x18\x94\xB8}\x93%,{X\x85\xBD(\xBD\xAD\x00,O\xAC\xECJ}\x99\xC7\xE2\xB6\x11\x9D\xDF\x12\xA5\x8F|\xF8\xC3Q\xDA\x95\x12\xEFH\xFFt\xCD\x854jJ\xE9\xE7\xC4\xDD|\xD4}w\xDAJ8\xAE\x17"
          #   rsa = Crypto::Key::RSA.load_file('key.pem')
          #   rsa.decrypt(encrypted, padding: pkcs1_oaep)
          #   # => "top secret"
          #
          def decrypt(data, padding: :pkcs1)
            padding_const = PADDINGS.fetch(padding) do
              raise(ArgumentError,"padding must be #{PADDINGS.keys.map(&:inspect).join(', ')}: #{padding.inspect}")
            end

            private_decrypt(data,padding_const)
          end

        end
      end
    end
  end
end
