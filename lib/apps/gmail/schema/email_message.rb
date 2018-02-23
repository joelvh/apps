require_relative 'base_context'

module Apps
  module Gmail
    module Schema
      class EmailMessage < BaseContext

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
