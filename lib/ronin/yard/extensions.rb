#
# Ronin EXT - A support library for Ronin.
#
# Copyright (c) 2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA  02110-1301  USA
#

require 'yard'

module Ronin
  module Yard
    module Extensions
      protected

      def effected_namespace
        if statement.type == :command_call
          context = statement.jump(:var_ref)

          unless context.source == 'self'
            return ensure_loaded!(
              Registry.resolve(namespace,context.source)
            )
          end
        end

        return namespace
      end

    end
  end
end