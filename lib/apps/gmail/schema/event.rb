require_relative 'rsvp_action'
require_relative 'place'

module Apps
  module Gmail
    module Schema
      class Event < Base
        include Schema::Concerns::PotentialAction
        
        attr_accessor :name, :start_date, :end_date, :location
        
        def serialize
          super.merge(
            "name" => name,
            "startDate" => start_date,
            "endDate" => end_date,
            "location" => location&.serialize
          )
        end

        def build_location(**attrs)
          self.location = Place.new(**attrs).tap do |place|
            place.build_address unless place.address
          end
        end

        def build_rsvp_actions
          actions.clear
          
          %w[Yes No Maybe].map { |response| add_action_for(response) }
        end
        
        def add_action_for(response, **attrs)
          RsvpAction.new(response: response, **attrs).tap do |action|
            actions << action
          end
        end
      end
    end
  end
end
