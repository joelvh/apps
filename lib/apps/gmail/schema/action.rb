require_relative '../../common/schema/base'

module Apps
  module Gmail
    module Schema
      class Action < ::Apps::Common::Schema::Base

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
