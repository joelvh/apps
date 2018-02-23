require_relative 'schema/event'
require_relative 'schema/email_message'
require_relative 'schema/parcel_delivery'
require_relative 'schema/confirm_action'
require_relative 'schema/save_action'
require_relative 'schema/view_action'
require_relative 'schema/track_action'

module Apps
  module Gmail
    module Markup
      class << self
        def build_confirm_action(description: nil, **attrs)
          Schema::EmailMessage.new(description: description, action: Schema::ConfirmAction.new(**attrs))
        end

        def build_save_action(description: nil, **attrs)
          Schema::EmailMessage.new(description: description, action: Schema::SaveAction.new(**attrs))
        end

        def build_rsvp_action(**attrs)
          Schema::Event.new(**attrs).tap do |event|
            event.build_location     unless event.location
            event.build_rsvp_actions unless event.actions.any?
          end
        end

        def build_view_action(target: nil, **attrs)
          Schema::EmailMessage.new(action: Schema::ViewAction.new(target: target), **attrs)
        end

        def build_track_action(target: nil, **attrs)
          Schema::ParcelDelivery.new(action: Schema::TrackAction.new(target: target), **attrs).tap do |email|
            email.build_delivery_address unless email.delivery_address
          end
        end
      end
    end
  end
end
