#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-support.
#
# ronin-support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-support.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/support/compression/zlib'
require 'ronin/support/compression/gzip'
require 'ronin/support/compression/core_ext'

module Ronin
  module Support
    #
    # @api public
    #
    # @since 1.0.0
    #
    module Compression
      #
      # Zlib inflate a string.
      #
      # @param [String] string
      #   The Zlib compressed input.
      #
      # @return [String]
      #   The Zlib inflated form of the input.
      #
      # @example
      #   Compression.zlib_inflate("x\x9C\xCBH\xCD\xC9\xC9\a\x00\x06,\x02\x15")
      #   # => "hello"
      #
      # @api public
      #
      def self.zlib_inflate(string)
        Zlib::Inflate.inflate(string)
      end

      #
      # Zlib deflate a string.
      #
      # @param [String] string
      #   The uncompressed input.
      #
      # @return [String]
      #   The Zlib deflated form of the input.
      #
      # @example
      #   Compression.zlib_deflate("hello")
      #   # => "x\x9C\xCBH\xCD\xC9\xC9\a\x00\x06,\x02\x15"
      #
      # @api public
      #
      def self.zlib_deflate(string)
        Zlib::Deflate.deflate(string)
      end

      #
      # Creates a gzip stream around the IO object.
      #
      # @param [IO, StringIO] io
      #   The IO object to read or write data to.
      #
      # @yield [gz]
      #   If a block is given, it will be passed the gzip stream object.
      #
      # @yieldparam [Zlib::GzipReader, Zlib::GzipWriter] gz
      #   The gzip reader or writer object.
      #
      # @return [Zlib::GzipReader, Zlib::GzipWriter]
      #   The gzip reader or writer object.
      #
      # @raise [ArgumentError]
      #   The mode must include either `r`, `w`, or `a`.
      #
      # @see https://rubydoc.info/stdlib/zlib/Zlib/GzipReader
      # @see https://rubydoc.info/stdlib/zlib/Zlib/GzipWriter
      #
      # @api public
      #
      def self.gzip_stream(io, mode: 'r', &block)
        GZip.wrap(io,mode: mode,&block)
      end

      #
      # Creates a gzip output stream around an IO object.
      #
      # @param [IO, StringIO] io
      #   The output IO object to write the gzipped data to.
      #
      # @yield [output]
      #   If a block is given, it will be passed the gzip writer object.
      #
      # @yieldparam [Zlib::GzipWriter] output
      #   The gzip writer object.
      #
      # @return [Zlib::GzipWriter]
      #   The gzip writer object.
      #
      # @raise [ArgumentError]
      #   The mode must include either `r`, `w`, or `a`.
      #
      # @see https://rubydoc.info/stdlib/zlib/Zlib/GzipWriter
      #
      # @api public
      #
      def self.gzip_open(path, mode: 'r', &block)
        GZip.open(path,mode: mode,&block)
      end

      #
      # Opens the gzipped file for reading.
      #
      # @param [String] path
      #   The path to the file to read.
      #
      # @yield [gz]
      #   If a block is given, it will be passed the gzip reader object.
      #
      # @yieldparam [Zlib::GzipReader] gz
      #   The gzip reader object.
      #
      # @return [Zlib::GzipReader]
      #   The gzip reader object.
      #
      # @see gzip_open
      #
      # @api public
      #
      def self.gunzip(path,&block)
        gzip_open(path,&block)
      end

      #
      # Opens the gzip file for writing.
      #
      # @param [String] path
      #   The path to the file to write to.
      #
      # @yield [gz]
      #   If a block is given, it will be passed the gzip writer object.
      #
      # @yieldparam [Zlib::GzipWriter] gz
      #   The gzip writer object.
      #
      # @return [Zlib::GzipWriter]
      #   The gzip writer object.
      #
      # @see gzip_open
      #
      # @api public
      #
      def self.gzip(path,&block)
        gzip_open(path,mode: 'w',&block)
      end
    end
  end
end
