require_relative 'input'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#multichoiceinput
      class MultichoiceInput < Input
        STYLES = %w[normal expanded].freeze

        attr_accessor :multiple, # Boolean - whether to allow selecting multiple choices
                      :style     # `normal` - dropdown
                                 # `expanded` - radio button list

        def choices
          @choices ||= {}
        end

        def serialize
          super.merge(
            "isMultiSelect" => multiple,
            "style" => style,
            "choices" => serialize_hash(choices, key: 'display')
          )
        end

        def add_choice(name, value)
          choices[name] = value
        end
      end
    end
  end
end
