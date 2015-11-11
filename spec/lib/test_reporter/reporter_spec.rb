require 'spec_helper'

describe TestReporter::Reporter do
  let(:app_name)    { '1-cherry-blossom' }
  let(:exercise_id) { '1' }
  let(:report)      { { failures_count: 0, app_name: app_name, exercise_id: exercise_id } }
  let(:reporter)    { described_class.new(report) }

  describe '.url' do
    it 'creates the correct url' do
      expect(reporter.url).to eq "http://admin.htw-webtech.dev:8081/api-v1/exercise_results/#{app_name}/#{exercise_id}.json"
    end
  end

  describe '.body' do
    it 'creates the correct body' do
      expect(reporter.body).to eq '{"report":{"failures_count":0,"app_name":"1-cherry-blossom","exercise_id":"1"}}'
    end
  end

  describe '.headers' do
    it 'creates the correct headers' do
      expect(reporter.headers).to eq({ 'x-created-with' => 'test-reporter' })
    end
  end
end
