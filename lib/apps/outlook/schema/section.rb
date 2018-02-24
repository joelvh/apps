module Apps
  module Outlook
    module Schema
      # See: https://docs.microsoft.com/en-us/outlook/actionable-messages/card-reference#section-fields
      class Section < Base
        include Schema::Concerns::PotentialAction
        include Schema::Concerns::SortedPotentialActions

        attr_accessor :title,
                      :text            # Markdown
        attr_accessor :start_group     # boolean, used to separate sections with divider lines
        attr_accessor :activity_title, # Markdown
                      :activity_subtitle, :activity_text, :activity_image
        attr_accessor :hero_image,     # url
                      :hero_title

        # Hash of key/value pairs displayed to call out specific points
        def facts
          @facts ||= {}
        end

        # Photo gallery (URL => title)
        def images
          @images ||= {}
        end

        def serialize
          super.merge(
            "title" => title,
            "startGroup" => start_group,
            "activityTitle" => activity_title,
            "activitySubtitle" => activity_subtitle,
            "activityText" => activity_text,
            "activityImage" => activity_image,
            "heroImage" => hero_image && serialize_image(hero_image => hero_title, key: 'image', value: 'title'),
            "text" => text,
            "facts" => serialize_hash(facts),
            "images" => serialize_hash(images, key: 'image', value: 'title')
          )
        end

        def add_fact(name, value)
          facts[name] = value
        end

        def add_image(url, title: nil)
          images[url] = title
        end
      end
    end
  end
end
