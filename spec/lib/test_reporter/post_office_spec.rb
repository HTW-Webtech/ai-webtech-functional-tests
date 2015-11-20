require 'spec_helper'

describe TestReporter::PostOffice do
  let(:app_name) { 'wooly-yak' }
  let(:exercise_id) { '1' }
  let(:report) { { app_name: app_name, exercise_id: exercise_id, success: true } }
  subject { described_class.new(app_name: app_name, exercise_id: exercise_id) }

  describe '#deliver_report' do
    before { allow(subject).to receive(:app_report).and_return(report) }

    it 'delegates reports to the reporter' do
      expect(TestReporter::Reporter).to receive(:new).with(report).and_call_original
      subject.deliver_report
    end
  end
end
