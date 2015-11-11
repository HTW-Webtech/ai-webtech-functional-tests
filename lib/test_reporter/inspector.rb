require 'nokogiri'

module TestReporter
  class Inspector
    class << self
      def fetch_report
        new(IO.binread(report_file_path)).report
      end

      def report_file_path(reports_path: default_reports_path)
        xml_files = Dir["#{reports_path}/*.xml"]
        xml_files.sort_by(&:length).last
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
      xml_doc.xpath('//failure').count
    end

    def report
      { failures_count: failures_count }
    end

    def xml_doc
       @xml_doc ||= Nokogiri::XML xml_report
    end
  end
end
