require_relative 'action'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#openuri-action
      class OpenUri < Action
        OPERATING_SYSTEMS = %w[default windows iOS android].freeze

        def targets
          @targets ||= {}
        end

        def serialize
          super.merge("targets" => serialize_hash(targets, key: 'os', value: 'uri'))
        end

        def add_target(url, os: 'default')
          targets[os] = url
        end
      end
    end
  end
end
