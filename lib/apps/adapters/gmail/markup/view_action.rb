require_relative 'base'

module Apps
  module Adapters
    module Gmail
      module Markup
        # See: https://developers.google.com/gmail/markup/reference/go-to-action
        # See: https://developers.google.com/gmail/markup/reference/types/ViewAction
        class ViewAction < Base

          attr_accessor :name, :target, :viewed
          
          def as_json
            prune super.merge(
              "name" => name,
              "target" => target,
              "viewed" => viewed&.as_json # Thing
            )
          end
        end
      end
    end
  end
end
