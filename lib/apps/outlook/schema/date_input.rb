require_relative 'input'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#dateinput
      class DateInput < Input

        attr_accessor :include_time # Boolean - whether to select time in addition to date

        def serialize
          super.merge("includeTime" => include_time)
        end
      end
    end
  end
end
