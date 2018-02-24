module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#inputs
      class Input < Base

        attr_accessor :id,       # Uniquely identifies input in a form
                      :required,
                      :title,    # Placeholder text or label
                      :value     # Initial value of input

        def serialize
          super.merge(
            "id" => id,
            "isRequired" => required,
            "title" => title,
            "value" => value
          )
        end
      end
    end
  end
end
