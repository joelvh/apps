require_relative '../../common/schema/base_context'

module Apps
  module Gmail
    module Schema
      class EmailMessage < ::Apps::Common::Schema::BaseContext

        attr_reader   :action
        attr_accessor :description, :publisher
        
        def serialize
          super.merge(
            "potentialAction" => action&.serialize,
            "publisher" => publisher&.serialize # Organization
          )
        end
      end
    end
  end
end
