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
            buffer = []
            buffer << %{<script type="application/ld+json">}
            buffer << to_json(pretty: true)
            buffer << %{</script>}
            buffer.join("\n")
          end
        end
      end
    end
  end
end
