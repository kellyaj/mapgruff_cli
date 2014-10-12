module Mapgruff
  class Sanitizer
    def self.sanitize(incidents)
      undesired_keys = ["id", "latitude", "longitude", "local_identifier", "location_icon", "arrest_status", "location_description"]
      incidents.each { |incident| undesired_keys.each { |k| incident.delete(k)} }
      incidents
    end
  end
end
