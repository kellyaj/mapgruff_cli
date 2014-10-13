Gem::Specification.new do |s|
  s.author = "Andrew Kelly"
  s.name = "mapgruff"
  s.summary = "A command line implementation of Mapgruff"
  s.version = "0.1.0"
  s.files = [
    "lib/mapgruff.rb",
    "lib/mapgruff/incident_fetcher.rb",
    "lib/mapgruff/presenter.rb",
    "lib/mapgruff/runner.rb",
    "lib/mapgruff/sanitizer.rb",
    "lib/mapgruff/table_generator.rb",
  ]
  s.bindir = "bin"
  s.require_paths = ["."]
  s.executables << "mapgruff"
end
