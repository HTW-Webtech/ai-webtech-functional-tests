require 'spec_helper'

describe TestReporter::PostOffice do
  subject { described_class.new }
  let(:success_report) { { app_name: 'Foo', exercise_id: 1, success: true } }
  let(:failure_report) { { app_name: 'Foo', exercise_id: 1, success: false } }

  describe '#deliver_report' do
    context 'for a success' do
      before do
        allow(subject).to receive(:app_report).and_return(success_report)
      end

      it 'should return awesome values' do
        byebug
      end
    end
  end
  # describe '.run' do
  #   let(:reporter)  { class_double('TestReporter::Reporter') }
  #   let(:inspector) { class_double('TestReporter::Inspector') }
  #   let(:report)    { Hash.new }
  #
  #   before do
  #     ENV['APP_NAME'] = 'foo'
  #     ENV['EXERCISE_ID'] = '1'
  #     allow(inspector).to receive(:success?).and_return(true)
  #   end
  #
  #   describe '#app_reports' do
  #     subject { described_class.app_report }
  #     it 'contains the correct information' do
  #       expect(subject).
  #     end
  #   end
  # end
end
