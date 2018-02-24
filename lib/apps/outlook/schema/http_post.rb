require_relative 'action'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#httppost-action
      class HttpPOST < Action
        # CARD-ACTION-STATUS - include header in server HTTP POST response
        # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#reporting-an-actions-execution-success-or-failure
        # CARD-UPDATE-IN-BODY - `true` value indicates to client to refresh content with response body
        # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#refresh-cards
        RESPONSE_HEADERS = %w[
          CARD-ACTION-STATUS
          CARD-UPDATE-IN-BODY
        ]
        MIME_TYPES = %w[
          application/json
          application/x-www-form-urlencoded
        ]

        attr_accessor :target, # URL
                      :body,   # body of the POST request
                      :body_content_type # MIME type of body

        def headers
          @headers ||= {}
        end

        def serialize
          super.merge(
            "target" => target,
            "headers" => serialize_hash(headers),
            "body" => body,
            "bodyContentType" => body_content_type
          )
        end

        def add_header(name, value)
          headers[name] = value
        end
      end
    end
  end
end
