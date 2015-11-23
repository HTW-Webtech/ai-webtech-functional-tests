require_relative 'test_reporter/inspector'
require_relative 'test_reporter/reporter'
require_relative 'test_reporter/post_office'

module TestReporter
  module_function

  def run(app_name:, exercise_id:)
    TestReporter::PostOffice.new(app_name: app_name, exercise_id: exercise_id).deliver_report
  end
end

