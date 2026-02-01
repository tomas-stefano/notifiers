# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "notifiers"
  s.version     = '2.0.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tomás D'Stefano"]
  s.email       = ["tomasdestefi@gmail.com"]
  s.homepage    = "https://rubygems.org/gems/notifiers"
  s.summary     = "Cross-platform desktop notifications for macOS and Linux."
  s.description = "Send desktop notifications on macOS (terminal-notifier, osascript) and Linux (notify-send, dunstify) in a simple and clean way."
  s.license     = "MIT"

  s.required_ruby_version     = ">= 3.0"
  s.required_rubygems_version = ">= 3.0"

  s.add_development_dependency('rspec', "~> 3.13")
  s.add_development_dependency('bundler', ">= 2.0")

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
