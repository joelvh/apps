require_relative 'concerns/sections'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference
      class MessageCard < Base
        include Schema::Concerns::Sections
        include Schema::Concerns::PotentialAction
        include Schema::Concerns::SortedPotentialActions

        HEADER_NAMES = %w[Card-Correlation-Id Action-Request-Id]
        
        attr_accessor :correlation_id     # UUID to track actions originating in email message
        attr_accessor :originator         # provider ID (required for actionable emails)
        attr_accessor :hide_original_body # For email only (hide email content if message card is duplicate)
        attr_accessor :summary, :title,
                      :text               # Markdown
        attr_accessor :theme_color

        def context
          'http://schema.org/extensions'
        end

        def serialize
          super.merge(
            "summary" => summary,
            "themeColor" => theme_color,
            "correlationId" => correlation_id,
            "originator" => originator,
            "hideOriginalBody" => hide_original_body,
            "title" => title,
            "text" => text
          )
        end
      end
    end
  end
end
