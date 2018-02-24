require_relative 'action'

module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#invokeaddincommand-action
      class InvokeAddInCommand < Action
        
        attr_accessor :add_in_id, # UUID from add-in's manifest
                      # Specifies the ID of the add-in command button that opens
                      # the required taskpane. The command button ID is found in
                      # the id attribute of the Control element that defines the
                      # button in the add-in's manifest. The specified Control element
                      # MUST be defined inside a `MessageReadCommandSurface` extension point,
                      # be of type Button, and the control's Action must be of type `ShowTaskPane`.
                      :desktop_command_id,
                      # Optional. Developers may specify any valid JSON object in
                      # this field. The value is serialized into a string and made
                      # available to the add-in when the action is executed. This
                      # allows the action to pass initialization data to the add-in.
                      :initialization_context

        def serialize
          super.merge(
            "addInId" => add_in_id,
            "desktopCommandId" => desktop_command_id,
            "initializationContext" => initialization_context
          )
        end
      end
    end
  end
end
