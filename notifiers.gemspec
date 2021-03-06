# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "notifiers"
  s.version     = '1.2.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tomás D'Stefano"]
  s.email       = ["tomasdestefi@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/notifiers"
  s.summary     = "Use notifiers like Growl, knotify in a simple and elegant way."
  s.description = "Use notifiers like Growl, knotify in a simple and clean way."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "notifiers"

  s.add_development_dependency('rspec', "~> 2.14")
  s.add_development_dependency('bundler', ">= 1.0.0")

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
