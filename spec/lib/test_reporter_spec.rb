require 'spec_helper'

describe TestReporter do
  describe '.run' do
    let(:reporter)  { class_double('TestReporter::Reporter') }
    let(:inspector) { class_double('TestReporter::Inspector') }
    let(:report)    { Hash.new }

    it 'reports stuff' do
      ENV['APP_NAME'] = 'foo'
      ENV['EXERCISE_ID'] = '1'
      expect(reporter).to receive(:report).with(report)
      expect(inspector).to receive(:fetch_report).and_return(report)
      described_class.run(inspector: inspector, reporter: reporter)
      expect(report[:app_name]).to eq ENV['APP_NAME']
      expect(report[:exercise_id]).to eq ENV['EXERCISE_ID']
    end
  end
end
