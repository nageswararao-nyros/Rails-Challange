class Address < ApplicationRecord
   geocoded_by :location
   reverse_geocoded_by :latitude, :longitude
   after_validation :geocode
end
