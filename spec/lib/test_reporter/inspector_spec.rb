require 'spec_helper'

describe TestReporter::Inspector do
  let(:failure_reports_path) { File.absolute_path(__FILE__ + '/../../../support/files/failure-and-error-reports') }
  let(:success_reports_path) { File.absolute_path(__FILE__ + '/../../../support/files/success-reports') }
  let(:error_file)   { "#{failure_reports_path}/SPEC-1-error.xml" }
  let(:failure_file) { "#{failure_reports_path}/SPEC-1-failure.xml" }
  let(:success_file) { "#{success_reports_path}/SPEC-no-failures-or-errors.xml" }

  describe 'Class' do
    subject { described_class }

    describe '.fetch_report' do
      context 'for a success' do
        let(:result) { subject.fetch_report(reports_path: success_reports_path) }

        it 'returns a success' do
          expect(result[:success]).to eq true
        end
      end

      context 'for a failure' do
        let(:result) { subject.fetch_report(reports_path: failure_reports_path) }

        it 'returns a failure' do
          expect(result[:success]).to eq false
        end
      end
    end

    describe '.default_reports_path' do
      it 'returns the correct report path' do
        expect(subject.default_reports_path).to eq File.absolute_path(__FILE__ + '/../../../reports')
      end
    end

    describe '.report_files' do
      let(:report_files) { subject.report_files(reports_path: failure_reports_path) }

      it 'returns the correct report file' do
        expect(report_files).to include error_file
        expect(report_files).to include failure_file
      end
    end
  end

  describe 'Instance' do
    subject { described_class.new(IO.binread(failure_file)) }

    describe '#failures_count' do
      it 'returns 1' do
        expect(subject.failures_count).to eq 1
      end
    end

    describe '#errors_count' do
      it 'returns 0' do
        expect(subject.errors_count).to eq 0
      end
    end

    describe '#report' do
      it 'returns the correct report' do
        expect(subject.report).to eq ({ failures_count: 1, errors_count: 0, success: false })
      end

      context 'with a success xml' do
        subject { described_class.new(IO.binread(success_file)) }

        it 'returns the correct report' do
          expect(subject.report).to eq ({ failures_count: 0, errors_count: 0, success: true })
        end
      end
    end
  end
end
