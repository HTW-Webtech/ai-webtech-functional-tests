require 'spec_helper'

describe TestReporter::Reporter do
  let(:two_failures_xml) { read_support_file('2_failures.xml') }

  describe '.report' do
    it 'creates the correct typhoeus request object'
    it 'adds the sign header'
  end
end
