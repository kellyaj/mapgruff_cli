Gem::Specification.new do |s|
  s.name          = "mapgruff"
  s.version       = "0.0.1"
  s.author        = "Andrew Kelly"
  s.email         = ["kellyaj@gmail.com"]
  s.summary       = "Tabular display of crime data for Chicago and Seattle."
  s.description   = "Tabular display of crime data for Chicago and Seattle."
  s.homepage      = "https://github.com/kellyaj/mapgruff_cli"
  s.license       = "MIT"
  s.files         = `git ls-files -z`.split("\x0")
  s.bindir        = "bin"
  s.require_paths = ["."]

  s.executables << "mapgruff"
end
