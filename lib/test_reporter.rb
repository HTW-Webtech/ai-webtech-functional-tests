## Make an HTTP post to: http://admin.htw-webtech.igelmund.info/results/:app_name/:exercise_id
# X-Signed-By: 'asdsandsajdksad'
# Body:
# { failures: 0 }

require_relative 'test_reporter/inspector'
require_relative 'test_reporter/reporter'

module TestReporter
  module_function

  def run
    reports = TestReporter::Inspector.fetch_reports
    TestReporter::Reporter.report reports
  end
end
