require_relative 'action'
require_relative 'http_post'
require_relative 'open_uri'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#actioncard-action
      class ActionCard < Action
        ACTIONS = [
          Schema::OpenUri,
          Schema::HttpPOST
        ].freeze

        def inputs
          @inputs ||= []
        end

        # OpenUriAction and HttpPostAction allowed
        def actions
          @actions ||= []
        end

        def serialize
          super.merge(
            "inputs" => inputs.map(&:serialize),
            "actions" => actions.select { |action| ACTIONS.include?(action.class) }.map(&:serialize)
          )
        end

        # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#input-value-substitution
        def input_value_substitutions(formatted: true)
          inputs.map do |input|
            key = "#{input.id}.value"
            
            formatted ? "{{#{key}}}" : key
          end
        end
      end
    end
  end
end
