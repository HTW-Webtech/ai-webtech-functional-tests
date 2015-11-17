require_relative 'inspector/report'

module TestReporter
  class Inspector
    attr_reader :reports_path

    def initialize(reports_path: default_reports_path)
      @reports_path = reports_path
    end

    def success?
      reports.all?(&:success?)
    end

    def reports
      report_files.map { |file| Report.new(IO.binread(file)) }
    end

    def report_files
      Dir["#{reports_path}/*.xml"]
    end

    def default_reports_path
      File.absolute_path(__FILE__ + '/../../../spec/reports')
    end
  end
end
