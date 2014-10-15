require 'mapgruff/presenter'
require 'mapgruff/table_generator'
require 'mapgruff/incident_fetcher'
require 'mapgruff/sanitizer'

module Mapgruff
  class Runner

    def initialize(output)
      @output = output
    end

    def run(options)
      limit = options[:limit].to_i
      incidents = IncidentFetcher.fetch_for_city(options[:city])
      sanitized_incidents = Sanitizer.sanitize(incidents.last(limit))
      generator = TableGenerator.new(sanitized_incidents)
      @presenter = Presenter.new(@output, generator)
      @presenter.present_table
    end

  end
end
