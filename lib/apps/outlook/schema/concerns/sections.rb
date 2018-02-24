module Apps
  module Outlook
    module Schema
      module Concerns
        module Sections
          def sections
            @sections ||= []
          end

          def serialize
            if sections.any?
              super.merge("sections" => sections.map(&:serialize))
            else
              super
            end
          end

          def add_section(title, **attrs)
            Section.new(title: title, **attrs).tap do |section|
              sections << section
            end
          end
        end
      end
    end
  end
end
