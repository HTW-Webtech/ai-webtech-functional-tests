require_relative 'inspector'
require_relative 'reporter'

module TestReporter
  class PostOffice
    attr_reader :inspector_klass, :reporter_klass

    def initialize(inspector_klass: TestReporter::Inspector, reporter_klass: TestReporter::Reporter)
      @inspector = inspector_klass.new
      @reporter_klass  = reporter_klass
    end

    def deliver_report
      reporter_klass.new(app_report).sent_report
    end

    def app_report
      {
        app_name: app_name,
        exercise_id: exercise_id,
        success: inspector.success?
      }
    end

    def app_name
      ENV.fetch('APP_NAME')
    end

    def exercise_id
      ENV.fetch('EXERCISE_ID')
    end
  end
end
