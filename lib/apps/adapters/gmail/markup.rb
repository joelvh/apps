require_relative 'markup/event'
require_relative 'markup/email_message'
require_relative 'markup/parcel_delivery'
require_relative 'markup/confirm_action'
require_relative 'markup/save_action'
require_relative 'markup/view_action'
require_relative 'markup/track_action'

module Apps
  module Adapters
    module Gmail
      module Markup
        class << self
          def build_confirm_action(description: nil, **attrs)
            EmailMessage.new(description: description, action: ConfirmAction.new(**attrs))
          end

          def build_save_action(description: nil, **attrs)
            EmailMessage.new(description: description, action: SaveAction.new(**attrs))
          end

          def build_rsvp_action(**attrs)
            Event.new(**attrs).tap do |event|
              event.build_location         unless event.location
              event.location.build_address unless event.location.address
              event.build_rsvp_actions     unless event.actions.any?
            end
          end

          def build_view_action(target: nil, **attrs)
            EmailMessage.new(action: ViewAction.new(target: target), **attrs)
          end

          def build_track_action(target: nil, **attrs)
            ParcelDelivery.new(action: TrackAction.new(target: target), **attrs).tap do |email|
              email.build_delivery_address unless email.delivery_address
            end
          end
        end
      end
    end
  end
end
