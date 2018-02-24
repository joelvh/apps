require_relative 'input'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#textinput
      class TextInput < Input

        attr_accessor :multiline, :max_length

        def serialize
          super.merge(
            "isMultiline" => multiline,
            "maxLength" => max_length
          )
        end
      end
    end
  end
end
