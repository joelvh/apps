require_relative 'base'
require_relative 'postal_address'

module Apps
  module Adapters
    module Gmail
      module Markup
        class Place < Base

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
end
