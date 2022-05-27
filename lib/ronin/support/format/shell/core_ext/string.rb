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

require 'ronin/support/format/text/core_ext/string'
require 'ronin/support/format/shell/core_ext/integer'

require 'strscan'

class String

  # Shell characters that must be back-slashed.
  SHELL_BACKSLASHED_CHARS = {
    '0'  => "\0",
    'a'  => "\a",
    'b'  => "\b",
    'e'  => "\e",
    't'  => "\t",
    'n'  => "\n",
    'v'  => "\v",
    'f'  => "\f",
    'r'  => "\r"
  }

  #
  # Shell escapes the characters in the String.
  #
  # @return [String]
  #   The shell escaped string.
  #
  # @example
  #   "hello\nworld".shell_escape
  #   # => "hello$'\\n'world"
  #
  # @api public
  #
  # @since 1.0.0
  #
  def shell_escape
    format_chars { |c| c.ord.shell_escape }
  end

  #
  # Shell unescapes the characters in the String.
  #
  # @return [String]
  #   The shell unescaped string.
  #
  # @example
  #   "hello$'\\n'world".shell_unescape
  #   # => "hello\nworld"
  #
  # @api public
  #
  # @since 1.0.0
  #
  def shell_unescape
    unescaped = String.new
    scanner   = StringScanner.new(self)

    until scanner.eos?
      if (backslash_char = scanner.scan(/\$'\\[0abetnvfr]'/)) # $'\n'
        unescaped << SHELL_BACKSLASHED_CHARS[backslash_char[3,1]]
      elsif (hex_char = scanner.scan(/\$'\\x[0-9a-fA-F]+'/)) # $'\XX'
        unescaped << hex_char[4..-2].to_i(16).chr
      elsif (unicode_char = scanner.scan(/\$'\\u[0-9a-fA-F]+'/)) # $'\uXXXX'
        unescaped << unicode_char[4..-2].to_i(16).chr(Encoding::UTF_8)
      else
        unescaped << scanner.getch
      end
    end

    return unescaped
  end

  #
  # Shell encodes every character in the String.
  #
  # @return [String]
  #   The shell encoded String.
  #
  # @example
  #   "hello world".shell_encode
  #   # => "$'\\x68'$'\\x65'$'\\x6c'$'\\x6c'$'\\x6f'$'\\x0a'$'\\x77'$'\\x6f'$'\\x72'$'\\x6c'$'\\x64'"
  #
  # @api public
  #
  # @since 1.0.0
  #
  def shell_encode
    format_chars { |c| c.ord.shell_encode }
  end

  alias shell_decode shell_unescape

  #
  # Converts the String into a double-quoted shell escaped String.
  #
  # @return [String]
  #   The quoted and escaped shell string.
  #
  # @example
  #   "hello\nworld".shell_string
  #   # => "\"hello$'\\n'world\""
  #
  # @api public
  #
  # @since 1.0.0
  #
  def shell_string
    "\"#{shell_escape}\""
  end

end
