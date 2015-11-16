require 'nokogiri'

# TODOS:
# - es müssen ALLE xml-Dateien berücksichtigt werden
module TestReporter
  class Inspector
    class << self
      def fetch_report(reports_path: default_reports_path)
        results = report_files(reports_path: reports_path).map { |file| new(IO.binread(file)) }
        {
          success: results.all?(&:success?)
        }
      end

      def report_files(reports_path: default_reports_path)
        Dir["#{reports_path}/*.xml"]
      end

      def default_reports_path
        File.absolute_path(__FILE__ + '/../../../spec/reports')
      end
    end

    attr_reader :xml_report

    def initialize(xml_report)
      @xml_report = xml_report
    end

    def failures_count
      xml_doc.xpath('//testsuite')[0]['failures'].to_i
    end

    def errors_count
      xml_doc.xpath('//testsuite')[0]['errors'].to_i
    end

    def success?
      errors_count == 0 && failures_count == 0
    end

    def report
      { failures_count: failures_count, errors_count: errors_count, success: success? }
    end

    def xml_doc
       @xml_doc ||= Nokogiri::XML xml_report
    end
  end
end
