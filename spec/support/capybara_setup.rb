require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :custom_poltergeist do |app|
  opts = {
    js_errors: true,
    debug: false,
    extensions: [
      # Patching Function.prototype.bind since phantomjs 1.9.8 seems
      # to have a bug: https://github.com/seiyria/bootstrap-slider/issues/344
      # PhantomJs 2 fixed that bug but is not yet available as a static binary
      # installable via npm phantomjs package.
      File.expand_path('../phantomjs-1.9.8-bind-fix.js', __FILE__)
    ]
  }
  Capybara::Poltergeist::Driver.new(app, opts)
end

Capybara.default_driver = :custom_poltergeist
Capybara.javascript_driver = :custom_poltergeist
Capybara.default_max_wait_time = 5
