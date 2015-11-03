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
$SERVER_PORT       = ENV.fetch('DEV_SERVER_PORT')

RSpec.configure do |config|
  config.include ValidatorHelper

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
  # TODO: Extract into some helper code
  if $TEST_ENV == 'development'
    config.before :suite do
      FileUtils.cd "solutions/exercise-#{$EXERCISE_ID}" do
        $SERVER_PID = Process.spawn("ruby -run -e httpd . -p #{$SERVER_PORT}", out: '/dev/null', err: '/dev/null')
        puts "Running local webserver on port #{$SERVER_PORT}, PID: #{$SERVER_PID}"
      end

      at_exit do
        if $SERVER_PID
          puts "Bringing down local webserver, PID: #{$SERVER_PID}"
          Process.kill 'TERM', $SERVER_PID
          Process.wait $SERVER_PID
        else
          puts "Warning: I did not get a PID."
        end
      end
    end
  end
end
