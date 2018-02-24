require_relative '../common/schema'

module Apps
  module Outlook
    module Schema
      include ::Apps::Common::Schema
    end
  end
end

require_relative 'schema/concerns'
require_relative 'schema/action_card'
require_relative 'schema/date_input'
require_relative 'schema/http_post'
require_relative 'schema/invoke_add_in_command'
require_relative 'schema/message_card'
require_relative 'schema/multichoice_input'
require_relative 'schema/open_uri'
require_relative 'schema/section'
require_relative 'schema/text_input'
