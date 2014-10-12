describe Mapgruff::Sanitizer do
  context "sanitizing incidents" do
    it "removes all unused keys" do
      incidents = [
        {
          "responder"            => "Jim",
          "altitude"             => "146",
          "id"                   => "123",
          "latitude"             => "1234.234",
          "longitude"            => "1234.234",
          "arrest_status"        => "at large",
          "location_description" => "somewhere",
          "local_identifier"     => "1234",
          "location_icon"        => "crime.png",
          "city"                 => "Seattle",
          "category"             => "PROPERTY",
          "primary_type"         => "car prowl",
          "description"          => "something",
          "date"                 => "8/9/2014 09:28",
          "block"                => "19XX 4th Ave"
        }]
      unused_keys = ["id", "latitude", "longitude", "local_identifier", "location_icon", "arrest_status", "location_description", "altitude", "responder"]

      sanitized_incidents = Mapgruff::Sanitizer.sanitize(incidents)

      sanitized_incidents.each do |incident|
        unused_keys.each { |key| expect(incident.keys).not_to include(key)}
      end
    end
  end
end
