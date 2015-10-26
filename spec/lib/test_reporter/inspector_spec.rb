require 'spec_helper'

describe TestReporter::Inspector do
  let(:two_failures_xml) { read_support_file('2_failures.xml') }

  describe '#failure_count' do
    let(:reporter) { described_class.new(two_failures_xml) }

    it 'returns 2 for the "2_failures.xml"' do
      expect(reporter.failures_count).to eq 2
    end
  end
end
