module Apps
  module Gmail
    module Schema
      # See: https://developers.google.com/gmail/markup/reference/go-to-action
      # See: https://developers.google.com/gmail/markup/reference/types/TrackAction
      class TrackAction < Base

        attr_accessor :name, :target, :delivery_method
        
        def serialize
          super.merge(
            "name" => name,
            "target" => target,
            "deliveryMethod" => delivery_method&.serialize # DeliveryMethod
          )
        end
      end
    end
  end
end
