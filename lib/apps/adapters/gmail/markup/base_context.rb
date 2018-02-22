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
            [%`<script type="application/ld+json">`, to_json(pretty: true), %`</script>`].join("\n")
          end
        end
      end
    end
  end
end
