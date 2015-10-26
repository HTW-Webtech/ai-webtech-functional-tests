require 'byebug'
# Load support files
Dir[File.expand_path('../support', __FILE__) + '/**/*.rb'].each { |rb| require rb }

# TODO: Remove once the reporter is extracted
require_relative '../lib/test_reporter'

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
end
