require_relative '../../common/schema/base'
require_relative 'postal_address'

module Apps
  module Gmail
    module Schema
      class Place < ::Apps::Common::Schema::Base

        attr_accessor :name, :same_as, :address
        
        def serialize
          super.merge(
            "sameAs" => same_as,
            "name" => name,
            "address" => address&.serialize
          )
        end

        def build_address(**attrs)
          self.address = PostalAddress.new(**attrs)
        end
      end
    end
  end
end
