require_relative '../common/schema'
require_relative '../common/schema/concerns'

module Apps
  module Gmail
    module Schema
      include ::Apps::Common::Schema
    end
  end
end

require_relative 'schema/confirm_action'
require_relative 'schema/email_message'
require_relative 'schema/event'
require_relative 'schema/parcel_delivery'
require_relative 'schema/place'
require_relative 'schema/postal_address'
require_relative 'schema/rsvp_action'
require_relative 'schema/save_action'
require_relative 'schema/track_action'
require_relative 'schema/view_action'
