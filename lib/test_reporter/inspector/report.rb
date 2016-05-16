require 'nokogiri'

module TestReporter
  class Inspector
    class Report
      attr_reader :xml_report

      def initialize(xml_report)
        @xml_report = xml_report
      end

      def tests_count
        xml_doc.xpath('//testsuite')[0]['tests'].to_i
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
        { tests_count: tests_count, failures_count: failures_count, errors_count: errors_count, success: success? }
      end

      def xml_doc
        @xml_doc ||= Nokogiri::XML xml_report
      end
    end
  end
end
