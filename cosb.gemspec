lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cosb/version"

Gem::Specification.new do |spec|
  spec.name          = "cosb"
  spec.version       = Cosb::VERSION
  spec.authors       = ["Nicola Bernardini", "Daniele Scarano"]
  spec.email         = ["nicola.bernardini.rome@gmail.com", "hellska@gmail.com"]

  spec.summary       = 'cosb is a Csound Orchestra Space Builder.'
  spec.description   = 'cosb is a Csound Orchestra Space Builder.'
  spec.homepage      = "https://github.com/nicb/cosb"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com/nicb/cosb"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "minitest", "~> 5.0"
end
