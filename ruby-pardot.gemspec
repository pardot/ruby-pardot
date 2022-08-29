# frozen_string_literal: true

require File.expand_path('lib/pardot/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'ruby-pardot'
  s.version     = Pardot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dan Cunning']
  s.email       = ['support@pardot.com']
  s.homepage    = 'http://github.com/pardot/ruby-pardot'
  s.summary     = 'Library for interacting with the Pardot API'
  s.description = 'Library for interacting with the Pardot API'

  s.required_ruby_version = '>= 2.6'
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "ruby-pardot"

  s.add_dependency 'crack', '0.4.4'
  s.add_dependency 'rexml', '3.2.5'
  s.add_dependency 'httparty', '0.18.1'

  s.add_development_dependency "bundler", ">= 1.10"
  s.add_development_dependency "rspec", "3.5.0"
  s.add_development_dependency "fakeweb", "1.3.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map { |f| f =~ %r{^bin/(.*)} ? Regexp.last_match(1) : nil }.compact
  s.require_path = 'lib'
end
