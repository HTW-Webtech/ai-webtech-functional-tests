require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

if ENV['TESTS_ENV'] == 'development'
  Capybara.register_driver :selenium_chrome do |app|
    opts = { browser: :chrome }
    Capybara::Selenium::Driver.new(app, opts)
  end
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
end
