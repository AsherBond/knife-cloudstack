# Author:: Chirag Jog (<chirag@clogeny.com>)
# Copyright:: Copyright (c) 2011 Clogeny Technologies.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife/cloudstack_base'

class Chef
  class Knife
    class CloudstackImageList < Knife

      include Knife::CloudstackBase

      banner "knife cloudstack image list (options)"

      def run

        validate!

        image_list = [
          ui.color('ID', :bold),
          ui.color('Name', :bold),
          ui.color('Size', :bold),
          ui.color('OS Type', :bold),
          ui.color('Location', :bold),
        ]

        connection.images.sort_by do |image|
          [image.name, image.id].compact
        end.each do |image|
          image_list << image.id
          image_list << image.name
          image_list << image.size
          image_list << image.ostypename
          image_list << image.zonename
        end

        image_list = image_list.map do |item|
          item.to_s
        end

        puts ui.list(image_list, :columns_across, 6)
      end
    end
  end
end
