require 'json'

module Apps
  module Adapters
    module Gmail
      module Markup
        class Base
          def initialize(**attrs)
            attrs.each do |name, value|
              next if value.nil?
              
              instance_variable_set(:"@#{name}", value)
            end
          end

          def type
            @type ||= self.class.name.split('::')[-1]
          end

          def as_json
            { "@type" => type }
          end

          def to_json(pretty: false)
            pretty ? JSON.pretty_generate(as_json) : JSON.dump(as_json)
          end
        
        protected

          def prune(hash)
            hash.reject { |_, value| value.nil? }
          end
        end
      end
    end
  end
end
