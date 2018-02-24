require_relative 'schema'

module Apps
  module Outlook
    module ActionableMessages
      class << self
        def message_card(summary, title, **attrs)
          Schema::MessageCard.new(summary: summary, title: title, **attrs)
        end
      end
    end
  end
end
