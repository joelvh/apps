module Apps
  module Common
    module Schema
      module Concerns
        module PotentialAction
          # Handles the case when there is one action
          def action
            actions.first if actions.size == 1
          end

          def actions
            @actions ||= [@action].compact
          end

          def serialize
            if actions.any?
              super.merge("potentialAction" => serialize_actions)
            else
              super
            end
          end
          
          def serialize_actions
            # Gmail uses a hash for one action and an array for multiple.
            # Outlook uses an array regardless and breaks if it's a hash.
            # So we will always return an array.
            
            # action&.serialize || actions.map(&:serialize)
            actions.map(&:serialize)
          end
        end
      end
    end
  end
end
