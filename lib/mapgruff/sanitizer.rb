module Mapgruff
  class Sanitizer

    USED_KEYS = ["city", "category", "primary_type", "description", "date", "block"]

    def self.sanitize(incidents)
      incidents.each do |incident|
        incident.keys.each { |k| incident.delete(k) unless USED_KEYS.include?(k)}
      end
      incidents
    end
  end
end
