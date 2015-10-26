require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist

if ENV['TEST_ENV'] == 'development'
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.current_driver = :selenium_chrome
end