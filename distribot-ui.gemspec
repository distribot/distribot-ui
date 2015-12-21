# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distribot-ui/version'

Gem::Specification.new do |spec|
  spec.name          = "distribot-ui"
  spec.version       = DistribotUI::VERSION
  spec.authors       = ["John Drago"]
  spec.email         = ["jdrago.999@gmail.com"]
  spec.summary       = %q{Web UI for Distribot}
  spec.description   = %q{Web UI for Distribot}
  spec.homepage      = "https://github.com/jdrago999/distribot-ui"
  spec.license       = "Apache"

  unless (ARGV & %w(rake build)).length.zero?
    # NOTE: `distribot-ui start` will run `bundle exec ...`. so this gemspec file evaluated by bundler then exec `git ls-files`
    #       but `git ls-files` would be warn if $PWD is not git dir, and unnecessary this step for to do it.
    #       And spec.files required for building a .gem only.
    #       Thus git ls-files only invoked with `rake build` command
    spec.files         = `git ls-files`.split($/)
  end
  spec.executables   = ["distribot-ui"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'web-console', '~> 2.0'

  spec.add_dependency 'rails', '4.2.5'
  spec.add_dependency 'font-awesome-rails'
  spec.add_dependency 'sass-rails', '~> 5.0'
  spec.add_dependency 'sprockets'

  spec.add_dependency 'bundler'
  spec.add_dependency 'puma'
  spec.add_dependency 'thor'
end
