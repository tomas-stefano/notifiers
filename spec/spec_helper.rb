
require 'notifiers'

RSpec.configure do |config|
  config.include Notifiers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end