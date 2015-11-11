require 'spec_helper'

describe TestReporter::Inspector do
  describe '.fetch_report' do
    it 'returns the correct report' do
      expect(described_class.fetch_report).to eq({ failures_count: 12 })
    end
  end

  describe '.default_reports_path' do
    it 'returns the correct report path' do
      expect(described_class.default_reports_path).to eq File.absolute_path(__FILE__ + '/../../../reports')
    end
  end

  describe '.report_file' do
    let(:reports_path) { File.absolute_path(__FILE__ + '/../../../support/files') }
    let(:expected_file_path) { "#{reports_path}/SPEC-Exercise-2-The-index-html-includes-a-style-css.xml" }

    it 'returns the correct report file' do
      expect(described_class.report_file_path(reports_path: reports_path)).to eq expected_file_path
    end
  end

  describe '#failure_count' do
    let(:two_failures_xml) { read_support_file('2_failures.xml') }
    let(:reporter) { described_class.new(two_failures_xml) }

    it 'returns 2 for the "2_failures.xml"' do
      expect(reporter.failures_count).to eq 2
    end
  end
end
