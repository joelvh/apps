require 'json'

module Apps
  module Common
    module Schema
      class Base
        DEFAULT_CONTEXT = 'http://schema.org'

        attr_reader :context,      # the schema.org URL if not the default
                    :force_context # force including the default schema.org context if none specified

        def initialize(**attrs)
          prune(attrs).each { |name, value| instance_variable_set(:"@#{name}", value) }
        end

        def type
          @type ||= self.class.name.split('::')[-1]
        end

        def serialize
          {
            "@context" => serialized_context,
            "@type" => type
          }
        end

        def serialize_hash(hash, key: 'name', value: 'value')
          hash.map do |k, v|
            {
              key => k,
              value => v
            }
          end
        end

        def serialized_context
          if force_context
            context || DEFAULT_CONTEXT
          else
            context
          end
        end
        
        def as_json(force_context: false)
          serialized = serialize

          if force_context == true
            serialized['@context'] ||= DEFAULT_CONTEXT
          elsif force_context.is_a?(String)
            serialized['@context'] = force_context
          end
          
          prune serialized
        end

        def to_json(force_context: false, pretty: false)
          hash = as_json(force_context: force_context)

          pretty ? JSON.pretty_generate(hash) : JSON.dump(hash)
        end
      
        def to_script(force_context: false, pretty: true)
          json = to_json(pretty: pretty, force_context: force_context)

          %`<script type="application/ld+json">\n#{json}\n</script>`
        end

      protected

        def prune(hash)
          hash.each_with_object({}) do |(key, value), result|
            # recursive prune
            result[key] = case value
                          when nil
                            next
                          when Array
                            next if value.empty?
                            value.map{ |v| v.is_a?(Hash) ? prune(v) : v }
                          when Hash
                            value = prune value
                            next if value.empty?
                            value
                          else
                            value
                          end
          end
        end
      end
    end
  end
end
