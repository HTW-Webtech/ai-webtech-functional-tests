module ExpectationsHelper
  def expected_image(name)
    File.expand_path(__dir__) + "/expectations/#{name}"
  end
end
