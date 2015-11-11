require_relative 'test_reporter/inspector'
require_relative 'test_reporter/reporter'

module TestReporter
  module_function

  def run(inspector: TestReporter::Inspector, reporter: TestReporter::Reporter)
    report = inspector.fetch_report
    report[:app_name] = app_name
    report[:exercise_id] = exercise_id
    reporter.report report
  end

  def app_name
    ENV.fetch('APP_NAME')
  end

  def exercise_id
    ENV.fetch('EXERCISE_ID')
  end
end
