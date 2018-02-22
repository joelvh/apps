require_relative 'base'

module Apps
  module Adapters
    module Gmail
      module Markup
        class Action < Base

          attr_accessor :handler_url
          
          def as_json
            prune super.merge(
              "handler" => {
                "@type" => "HttpActionHandler",
                "url" => handler_url
              }
            )
          end
        end
      end
    end
  end
end
