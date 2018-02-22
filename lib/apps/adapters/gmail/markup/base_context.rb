require_relative 'base'

module Apps
  module Adapters
    module Gmail
      module Markup
        class BaseContext < Base
          def as_json
            { "@context" => "http://schema.org" }.merge(super)
          end

          def to_script
            %`<script type="application/ld+json">\n#{to_json(pretty: true)}\n</script>`
          end
        end
      end
    end
  end
end
