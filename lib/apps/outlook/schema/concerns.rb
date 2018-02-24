require_relative '../../common/schema/concerns'

module Apps
  module Outlook
    module Schema
      module Concerns
        include ::Apps::Common::Schema::Concerns
      end
    end
  end
end

require_relative 'concerns/sections'
require_relative 'concerns/sorted_potential_action'
