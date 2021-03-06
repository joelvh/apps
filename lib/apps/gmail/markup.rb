require_relative 'schema'

module Apps
  module Gmail
    module Markup
      class << self
        # {
        #   "@context": "http://schema.org",
        #   "@type": "EmailMessage",
        #   "potentialAction": {
        #     "@type": "ConfirmAction",
        #     "handler": {
        #       "@type": "HttpActionHandler",
        #       "url": "https://example.org/confirm/endpoint"
        #     },
        #     "name": "Action Name"
        #   }
        # }
        def confirm_action(name, url, **attrs)
          action = Schema::ConfirmAction.new(name: name, url: url)
          root   = Schema::EmailMessage.new(action: action, **attrs)

          root
        end

        # {
        #   "@context": "http://schema.org",
        #   "@type": "EmailMessage",
        #   "potentialAction": {
        #     "@type": "SaveAction",
        #     "handler": {
        #       "@type": "HttpActionHandler",
        #       "url": "https://example.org/save/endpoint"
        #     },
        #     "name": "Action Name"
        #   }
        # }
        def save_action(name, url, **attrs)
          action = Schema::SaveAction.new(name: name, url: url)
          root   = Schema::EmailMessage.new(action: action, **attrs)

          root
        end

        # {
        #   "@context": "http://schema.org",
        #   "@type": "Event",
        #   "name": "Action Name",
        #   "location": {
        #     "@type": "Place",
        #     "address": {
        #       "@type": "PostalAddress"
        #     }
        #   },
        #   "potentialAction": [
        #     {
        #       "@type": "RsvpAction",
        #       "handler": {
        #         "@type": "HttpActionHandler",
        #         "url": "http://example.org/yes/endpoint"
        #       },
        #       "rsvpResponse": "yes",
        #       "attendance": "http://schema.org/RsvpAttendance/Yes"
        #     },
        #     {
        #       "@type": "RsvpAction",
        #       "handler": {
        #         "@type": "HttpActionHandler",
        #         "url": "http://example.org/no/endpoint"
        #       },
        #       "rsvpResponse": "no",
        #       "attendance": "http://schema.org/RsvpAttendance/No"
        #     },
        #     {
        #       "@type": "RsvpAction",
        #       "handler": {
        #         "@type": "HttpActionHandler",
        #         "url": "http://example.org/maybe/endpoint"
        #       },
        #       "rsvpResponse": "maybe",
        #       "attendance": "http://schema.org/RsvpAttendance/Maybe"
        #     }
        #   ]
        # }
        def rsvp_action(name, yes_url: nil, no_url: nil, maybe_url: nil, **attrs)
          Schema::Event.new(name: name, **attrs).tap do |root|
            root.build_location     unless root.location
            root.build_rsvp_actions unless root.actions.any?

            responses = {
              'Yes' => yes_url,
              'No' => no_url,
              'Maybe' => maybe_url
            }

            # Specify RSVP URLs
            responses.each do |response, url|
              next if url.nil?

              action = root.actions.find { |action| action.response == response }
              action ||= root.add_action_for(response)

              action.url = url
            end
          end
        end

        # {
        #   "@context": "http://schema.org",
        #   "@type": "EmailMessage",
        #   "potentialAction": {
        #     "@type": "ViewAction",
        #     "name": "Action Name",
        #     "target": "http://example.org/view/endpoint"
        #   }
        # }
        def view_action(name, target, **attrs)
          action = Schema::ViewAction.new(name: name, target: target)
          root   = Schema::EmailMessage.new(action: action, **attrs)

          root
        end

        # {
        #   "@context": "http://schema.org",
        #   "@type": "ParcelDelivery",
        #   "deliveryAddress": {
        #     "@type": "PostalAddress"
        #   },
        #   "carrier": {
        #     "@type": "Organization"
        #   },
        #   "itemShipped": {
        #     "@type": "Product"
        #   },
        #   "partOfOrder": {
        #     "@type": "Order",
        #     "merchant": {
        #       "@type": "Organization"
        #     }
        #   },
        #   "potentialAction": {
        #     "@type": "TrackAction",
        #     "name": "Action Name",
        #     "target": "https://example.org/track/endpoint"
        #   }
        # }
        def track_action(name, target, **attrs)
          action = Schema::TrackAction.new(name: name, target: target)
          
          Schema::ParcelDelivery.new(action: action, **attrs).tap do |root|
            root.build_delivery_address unless root.delivery_address
          end
        end
      end
    end
  end
end
