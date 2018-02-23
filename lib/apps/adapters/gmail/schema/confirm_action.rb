require_relative 'action'

module Apps
  module Adapters
    module Gmail
      module Schema
        # See: https://developers.google.com/gmail/markup/reference/one-click-action
        # See: https://developers.google.com/gmail/markup/reference/types/ConfirmAction
        class ConfirmAction < Action

          attr_accessor :name, :confirmed
          
          def serialize
            super.merge(
              "name" => name,
              "confirmed" => confirmed&.serialize # Thing
            )
          end
        end
      end
    end
  end
end
