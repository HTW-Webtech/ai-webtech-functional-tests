require_relative 'inspector'
require_relative 'reporter'

module TestReporter
  class PostOffice
    attr_reader :app_name, :exercise_id, :inspector, :reporter_klass

    def initialize(app_name:, exercise_id:)
      @app_name       = app_name
      @exercise_id    = exercise_id
      @inspector      = TestReporter::Inspector.new
      @reporter_klass = TestReporter::Reporter
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
  end
end
