require 'open-uri'
require 'digest'

describe 'HTTP Exercise' do
  SECRET_TXT_URL = "#{$EXERCISE_BASE_URL}/secret.txt"
  let(:secret) { open(SECRET_TXT_URL).read.chomp }
  let(:secret_code) { 'ASDSADDHASD' }
  let(:app_id) { $APP_NAME }

  it 'contains a secret.txt file with the right secret' do
    secret_base = "#{Digest::SHA256.new.hexdigest("#{secret_code}#{app_id}")[0..5]}"
    secret_challenge = "#{Digest::SHA256.new.hexdigest("#{secret_code}#{secret_base}")[0..5]}"
    expect(secret).to eq(secret_challenge)
  end
end
