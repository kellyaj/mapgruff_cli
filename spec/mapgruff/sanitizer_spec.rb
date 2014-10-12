describe Mapgruff::Sanitizer do
  context "sanitizing incidents" do
    it "removes unused keys from incidents hash" do
      incidents = [
        {
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
      unused_keys = ["id", "latitude", "longitude", "local_identifier", "location_icon", "arrest_status", "location_description"]

      sanitized_incidents = Mapgruff::Sanitizer.sanitize(incidents)

      unused_keys.each { |key| expect(sanitized_incidents).not_to include(key)}
    end
  end
end
