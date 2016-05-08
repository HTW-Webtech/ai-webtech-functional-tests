require 'open-uri'
require 'digest'

describe 'Ruby Exercise' do
  GIT_REPO_PATH   = "/var/apps/#{$APP_NAME}/code"
  GIT_TARGET_PATH = "./vendor/code"

  it 'runs all koans successfully' do
    system "test -e #{GIT_TARGET_PATH} || git clone #{GIT_REPO_PATH} #{GIT_TARGET_PATH}"
    FileUtils.cd GIT_TARGET_PATH do
      result = `rake`.include?("meditate on the following code")
      expect(result).to eq(false), "You did not finish all the koans yet."
    end
  end
end
