require_relative 'action'

module Apps
  module Adapters
    module Gmail
      module Markup
        # See: https://developers.google.com/gmail/markup/reference/one-click-action
        # See: https://developers.google.com/gmail/markup/reference/types/ConfirmAction
        class ConfirmAction < Action

          attr_accessor :name, :confirmed
          
          def as_json
            prune super.merge(
              "name" => name,
              "confirmed" => confirmed&.as_json # Thing
            )
          end
        end
      end
    end
  end
end
