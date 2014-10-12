require_relative 'presenter'
require_relative 'table_generator'
require_relative 'incident_fetcher'

module Mapgruff
  class Runner

    def initialize(output)
      @output = output
    end

    def run(city)
      incidents = IncidentFetcher.fetch_for_city(city)
      last_five = incidents.last(5)
      generator = TableGenerator.new(sanitize_incidents(last_five))
      @presenter = Presenter.new(@output, generator)
      @presenter.present_table
    end

    def sanitize_incidents(incidents)
      undesired_keys = ["id", "latitude", "longitude", "local_identifier", "location_icon", "arrest_status", "location_description"]
      incidents.each { |incident| undesired_keys.each { |k| incident.delete(k)} }
      incidents
    end
  end
end
