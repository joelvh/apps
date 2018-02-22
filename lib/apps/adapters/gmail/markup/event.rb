require_relative 'base_context'
require_relative 'rsvp_action'
require_relative 'place'

module Apps
  module Adapters
    module Gmail
      module Markup
        class Event < BaseContext

          attr_accessor :name, :start_date, :end_date, :location
          
          def as_json
            prune super.merge(
              "name" => name,
              "startDate" => start_date,
              "endDate" => end_date,
              "location" => location&.as_json,
              "potentialAction" => actions.map(&:as_json)
            )
          end

          def actions
            @actions ||= []
          end

          def build_location(**attrs)
            self.location = Place.new(**attrs).tap do |place|
              place.build_address unless place.address
            end
          end

          def build_rsvp_actions
            actions.clear.concat(%w[Yes No Maybe].map { |response| RsvpAction.new(response: response) })
          end
        end
      end
    end
  end
end
