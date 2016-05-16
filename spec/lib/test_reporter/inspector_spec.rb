require 'spec_helper'

describe TestReporter::Inspector do
  let(:failure_reports_path) { File.absolute_path(__FILE__ + '/../../../support/files/failure-and-error-reports') }
  let(:success_reports_path) { File.absolute_path(__FILE__ + '/../../../support/files/success-reports') }

  context 'for a success report' do
    subject { described_class.new(reports_path: success_reports_path) }

    describe '#success?' do
      it 'returns true' do
        expect(subject).to be_success
      end
    end

    describe '#tests_count' do
      it 'returns 2' do
        expect(subject.tests_count).to eq(2)
      end
    end

    describe '#success_count' do
      it 'returns 2' do
        expect(subject.success_count).to eq(2)
      end
    end
  end

  context 'for a failure report' do
    subject { described_class.new(reports_path: failure_reports_path) }

    describe '#success?' do
      it 'returns false' do
        expect(subject).to_not be_success
      end
    end

    describe '#tests_count' do
      it 'returns 4' do
        expect(subject.tests_count).to eq(4)
      end
    end

    describe '#success_count' do
      it 'returns 2' do
        expect(subject.success_count).to eq(2)
      end
    end
  end

  describe '#default_reports_path' do
    subject { described_class.new }
    let(:expected_path) { File.absolute_path(__FILE__ + '/../../../reports') }

    it 'returns the correct path' do
      expect(subject.default_reports_path).to eq expected_path
    end
  end

  describe '.default_reports_path' do
    it 'returns the correct report path' do
      expect(subject.default_reports_path).to eq File.absolute_path(__FILE__ + '/../../../reports')
    end
  end
end
