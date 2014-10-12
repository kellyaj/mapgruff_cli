require_relative 'presenter'
require_relative 'table_generator'
require_relative 'incident_fetcher'
require_relative 'sanitizer'

module Mapgruff
  class Runner

    def initialize(output)
      @output = output
    end

    def run(city)
      incidents = IncidentFetcher.fetch_for_city(city)
      sanitized_incidents = Sanitizer.sanitize(incidents.last(5))
      generator = TableGenerator.new(sanitized_incidents)
      @presenter = Presenter.new(@output, generator)
      @presenter.present_table
    end

  end
end
