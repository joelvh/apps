module Apps
  module Gmail
    module Schema
      class EmailMessage < Base
        include Schema::Concerns::PotentialAction
        
        attr_accessor :description, :publisher
        
        def serialize
          super.merge("publisher" => publisher&.serialize) # Organization
        end
      end
    end
  end
end
