require 'nokogiri'

module TestReporter
  class Inspector
    def self.fetch_reports
      xml_files = Dir["#{File.absolute_path(__FILE__ + '/../../spec/reports')}/*"]
      xml_files.each_with_object([]) do |xml_file, reports|
        xml_report = IO.binread(xml_file)
        reports << new(xml_report).report
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
