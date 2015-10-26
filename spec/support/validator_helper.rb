module ValidatorHelper
  VALIDATOR_URL = 'https://validator.w3.org/nu/?showsource=yes&useragent=Validator.nu%2FLV+http%3A%2F%2Fvalidator.w3.org%2Fservices&doc={URL}'

  def visit_validation_page(url)
    visit VALIDATOR_URL.gsub('{URL}', url)
  end
end
