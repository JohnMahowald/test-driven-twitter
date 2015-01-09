require "codeclimate-test-reporter"
require "capybara/rspec"

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.include Capybara::DSL
  config.disable_monkey_patching!
end
