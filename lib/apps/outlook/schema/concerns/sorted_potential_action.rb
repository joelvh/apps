module Apps
  module Outlook
    module Schema
      module Concerns
        module SortedPotentialActions
          def serialize_actions
            # OpenUri action is supposed to be last
            # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#openuri-action
            actions.sort! { |a, b| a.class == b.class ? 0 : a.is_a?(OpenUri) ? -1 : 1 }

            super
          end
        end
      end
    end
  end
end
