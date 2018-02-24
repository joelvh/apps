module Apps
  module Gmail
    module Schema
      class PostalAddress < Base

        attr_accessor :name, :street, :locality, :region, :po_box, :postal_code, :country
        
        def serialize
          super.merge(
            "name" => name,
            "streetAddress" => street,       # street address
            "addressLocality" => locality,   # city
            "addressRegion" => region,       # state (abbr)
            "postOfficeBoxNumber" => po_box,
            "postalCode" => postal_code,     # zip code
            "addressCountry" => country
          )
        end
      end
    end
  end
end
