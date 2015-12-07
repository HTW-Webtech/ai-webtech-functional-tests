require 'fileutils'
require 'byebug'
require 'complex_config/rude'
require 'html_validation'

ComplexConfig.configure do |config|
  config.env = ENV.fetch('TESTS_ENV')
end

# Load support files
Dir[File.expand_path('../support', __FILE__) + '/**/*.rb'].each { |rb| require rb }

# Load TestReport
require_relative '../lib/test_reporter'

# Load configuration from ENV
$EXERCISE_ID       = ENV.fetch('EXERCISE_ID')
$EXERCISE_BASE_URL = ENV.fetch('EXERCISE_BASE_URL')

RSpec.configure do |config|
  config.include SupportFiles
  config.include PoltergeistHelper
  config.include PageValidations

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if ComplexConfig::Provider.env == 'development'
    # Capybara.register_driver :selenium_chrome do |app|
    #   opts = { browser: :chrome }
    #   Capybara::Selenium::Driver.new(app, opts)
    # end
    # Capybara.default_driver = :selenium_chrome
    # Capybara.javascript_driver = :selenium_chrome
    Capybara.default_driver = :custom_poltergeist
    Capybara.javascript_driver = :custom_poltergeist

    server_port = ENV.fetch('DEV_SERVER_PORT')
    server_root_path = "solutions/exercise-#{$EXERCISE_ID}"
    LocalWebServer.setup(port: server_port, server_root_path: server_root_path, config: config)
  end
end
