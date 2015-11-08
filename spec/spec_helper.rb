require 'fileutils'
require 'byebug'

# Load support files
Dir[File.expand_path('../support', __FILE__) + '/**/*.rb'].each { |rb| require rb }

# Load TestReport
require_relative '../lib/test_reporter'

# Load configuration from ENV
$TEST_ENV          = ENV.fetch('TEST_ENV')
$EXERCISE_ID       = ENV.fetch('EXERCISE_ID')
$EXERCISE_BASE_URL = ENV.fetch('EXERCISE_BASE_URL')
$USER_NAME         = ENV.fetch('USER_NAME')
$USER_NAME         = ENV.fetch('USER_EMAIL')

RSpec.configure do |config|
  config.include ValidatorHelper
  config.include ExpectationsHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.after :all do
    # TODO: remove me
    if self.respond_to?(:page)
      if page.driver.browser.respond_to?(:close)
        page.driver.browser.close
      end
    end
  end

  # Local test settings
  if $TEST_ENV == 'development'
    $SERVER_PORT = ENV.fetch('DEV_SERVER_PORT')
    config.before :suite do
      # TODO: Extract into some helper code
      puts "Bringing up local webserver on port #{$SERVER_PORT}"
      $SERVER_PID = fork do
        FileUtils.cd "solutions/exercise-#{$EXERCISE_ID}" do
          exec "ruby -run -e httpd . -p #{$SERVER_PORT}"
        end
      end

      at_exit do
        puts "Bringing down local webserver"
        Process.kill 'TERM', $SERVER_PID
        Process.wait $SERVER_PID
      end
    end
  end
end
