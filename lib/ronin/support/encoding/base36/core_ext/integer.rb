# frozen_string_literal: true
#
# Copyright (c) 2006-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/support/encoding/base36'

class Integer

  #
  # Base36 encodes the Integer.
  #
  # @return [String]
  #   The Base36 encoded String.
  #
  # @example
  #   1000.base36_encode
  #   # => "rs"
  #
  # @see https://en.wikipedia.org/wiki/Base36
  #
  # @api public
  #
  # @since 1.1.0
  #
  def base36_encode
    Ronin::Support::Encoding::Base36.encode_int(self)
  end

end
