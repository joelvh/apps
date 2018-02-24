module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#actions
      class Action < Base
        attr_accessor :name # Button text

        def serialize
          super.merge("name" => name)
        end
      end
    end
  end
end
