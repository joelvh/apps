require_relative 'base'

module Apps
  module Gmail
    module Schema
      class Action < Base

        attr_accessor :url
        
        def serialize
          super.merge(
            "handler" => {
              "@type" => "HttpActionHandler",
              "url" => url
            }
          )
        end
      end
    end
  end
end
