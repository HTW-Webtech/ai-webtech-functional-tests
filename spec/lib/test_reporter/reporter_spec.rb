require 'spec_helper'

describe TestReporter::Reporter do
  let(:app_name)    { '1-cherry-blossom' }
  let(:exercise_id) { '1' }
  let(:success_report) { { success: true, app_name: app_name, exercise_id: exercise_id } }
  let(:failure_report) { { success: false, app_name: app_name, exercise_id: exercise_id } }
  subject { described_class.new(success_report) }

  describe '.url' do
    it 'creates the correct url' do
      expect(subject.url).to eq "http://admin.htw-webtech.dev:8081/api-v1/exercise_results/#{app_name}/#{exercise_id}.json"
    end
  end

  describe '.body' do
    it 'creates the correct body' do
      expect(subject.body).to eq '{"report":{"success":true,"app_name":"1-cherry-blossom","exercise_id":"1"}}'
    end

    context 'for a failure' do
      subject { described_class.new(failure_report) }

      it 'creates the correct body' do
        expect(subject.body).to eq '{"report":{"success":false,"app_name":"1-cherry-blossom","exercise_id":"1"}}'
      end
    end
  end

  describe '.headers' do
    it 'creates the correct headers' do
      expect(subject.headers).to eq({ 'x-created-with' => 'test-reporter' })
    end
  end
end
