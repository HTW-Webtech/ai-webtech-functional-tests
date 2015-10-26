require 'byebug'
require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist

# TODO: Remove once the reporter is extracted
require_relative '../lib/test_reporter'

if ENV['TEST_ENV'] == 'development'
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.current_driver = :selenium_chrome
end

def read_support_file(file_name)
  IO.binread(File.expand_path(__dir__) + "/support/files/#{file_name}")
end

RSpec.configure do |config|
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
