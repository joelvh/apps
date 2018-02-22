require_relative 'base'

module Apps
  module Adapters
    module Gmail
      module Markup
        # See: https://developers.google.com/gmail/markup/reference/go-to-action
        # See: https://developers.google.com/gmail/markup/reference/types/TrackAction
        class TrackAction < Base

          attr_accessor :name, :target, :delivery_method
          
          def as_json
            prune super.merge(
              "name" => name,
              "target" => target,
              "deliveryMethod" => delivery_method&.as_json # DeliveryMethod
            )
          end
        end
      end
    end
  end
end
