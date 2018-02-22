require_relative 'base_context'

module Apps
  module Adapters
    module Gmail
      module Markup
        class EmailMessage < BaseContext

          attr_reader   :action
          attr_accessor :description, :publisher
          
          def as_json
            prune super.merge(
              "potentialAction" => action&.as_json,
              "publisher" => publisher&.as_json # Organization
            )
          end
        end
      end
    end
  end
end
