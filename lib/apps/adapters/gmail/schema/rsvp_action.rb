require_relative 'action'

module Apps
  module Adapters
    module Gmail
      module Schema
        # See: https://developers.google.com/gmail/markup/reference/rsvp-action
        class RsvpAction < Action

          attr_accessor :response, :additional_number_of_guests, :bringing_kids, :bringing_other_people
          
          def serialize
            super.merge(
              "rsvpResponse" => response.downcase,
              "additionalNumberOfGuests" => additional_number_of_guests&.to_i,
              "bringingKids" => bringing_kids&.to_i,
              "bringingOtherPeople" => bringing_other_people&.to_i,
              # "comment" => {},
              # "event" => {},
              "attendance" => "http://schema.org/RsvpAttendance/#{response.capitalize}"
            )
          end
        end
      end
    end
  end
end
