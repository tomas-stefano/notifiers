require 'bundler/setup'
require 'notifiers'

RSpec.configure do |config|
  config.include Notifiers
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

shared_examples_for 'a notifier' do
  describe '#notify' do
    it { expect(subject).to respond_to(:notify) }
  end
end