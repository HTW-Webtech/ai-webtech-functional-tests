require 'rspec/page-regression'

RSpec::PageRegression.configure do |config|
  config.page_size = [1280, 1024]
  config.threshold = 0.01
end
