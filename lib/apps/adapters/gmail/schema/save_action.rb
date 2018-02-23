require_relative 'action'

module Apps
  module Adapters
    module Gmail
      module Schema
        # See: https://developers.google.com/gmail/markup/reference/one-click-action
        # See: https://developers.google.com/gmail/markup/reference/types/SaveAction
        class SaveAction < Action

          attr_accessor :name
          
          def serialize
            super.merge(
              "name" => name
            )
          end
        end
      end
    end
  end
end
