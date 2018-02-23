require_relative 'base_context'
require_relative 'postal_address'

module Apps
  module Gmail
    module Schema
      class ParcelDelivery < BaseContext

        attr_reader   :action
        attr_accessor :delivery_address, :expected_arrival_until, :carrier_name
        attr_accessor :product_name, :order_number, :merchant_name
        attr_accessor :tracking_url
        
        def serialize
          super.merge(
            "deliveryAddress" => delivery_address&.serialize,
            "expectedArrivalUntil" => expected_arrival_until,
            "carrier" => {
              "@type" => "Organization",
              "name" => carrier_name
            },
            "itemShipped" => {
              "@type" => "Product",
              "name" => product_name
            },
            "partOfOrder" => {
              "@type" => "Order",
              "orderNumber" => order_number,
              "merchant" => {
                "@type" => "Organization",
                "name" => merchant_name
              }
            },
            "trackingUrl" => tracking_url,
            "potentialAction" => action&.serialize
          )
        end

        def build_delivery_address(**attrs)
          self.delivery_address = PostalAddress.new(**attrs)
        end
      end
    end
  end
end
