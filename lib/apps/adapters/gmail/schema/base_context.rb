require_relative 'base'

module Apps
  module Adapters
    module Gmail
      module Schema
        class BaseContext < Base
          def serialize
            { "@context" => "http://schema.org" }.merge(super)
          end

          def to_script(pretty: true)
            %`<script type="application/ld+json">\n#{to_json(pretty: pretty)}\n</script>`
          end
        end
      end
    end
  end
end