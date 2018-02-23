require 'json'

module Apps
  module Gmail
    module Schema
      class Base
        def initialize(**attrs)
          prune(attrs).each { |name, value| instance_variable_set(:"@#{name}", value) }
        end

        def type
          @type ||= self.class.name.split('::')[-1]
        end

        def serialize
          { "@type" => type }
        end

        def as_json
          prune serialize
        end

        def to_json(pretty: false)
          pretty ? JSON.pretty_generate(as_json) : JSON.dump(as_json)
        end
      
      protected

        def prune(hash)
          hash.each_with_object({}) do |(key, value), result|
            # recursive prune
            result[key] = case value
                          when nil   then next
                          when Array then value.map{ |v| v.is_a?(Hash) ? prune(v) : v }
                          when Hash  then prune value
                          else value
                          end
          end
        end
      end
    end
  end
end
