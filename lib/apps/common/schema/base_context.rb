require_relative 'base'

module Apps
  module Common
    module Schema
      class BaseContext < Base
        DEFAULT_CONTEXT_URI = 'http://schema.org'

        def context_uri
          @context_uri || DEFAULT_CONTEXT_URI
        end

        def serialize
          { "@context" => context_uri }.merge(super)
        end

        def to_script(pretty: true)
          %`<script type="application/ld+json">\n#{to_json(pretty: pretty)}\n</script>`
        end
      end
    end
  end
end
