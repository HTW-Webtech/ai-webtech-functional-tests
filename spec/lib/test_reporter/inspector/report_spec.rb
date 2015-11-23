describe TestReporter::Inspector::Report do
  let(:failure_xml) { read_support_file('failure-and-error-reports/SPEC-1-failure.xml') }
  subject { described_class.new(failure_xml) }

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
      let(:success_xml) { read_support_file('success-reports/SPEC-success.xml') }
      subject { described_class.new(success_xml) }

      it 'returns the correct report' do
        expect(subject.report).to eq ({ failures_count: 0, errors_count: 0, success: true })
      end
    end
  end
end
