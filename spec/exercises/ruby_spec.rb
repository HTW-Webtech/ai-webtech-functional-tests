describe 'Ruby Exercise' do
  GIT_REPO_PATH   = "/var/apps/#{$APP_NAME}/code"
  GIT_TARGET_PATH = "./vendor/ruby_koans_code"

  it 'runs all koans successfully' do
    system "test -e #{GIT_TARGET_PATH} || git clone #{GIT_REPO_PATH} #{GIT_TARGET_PATH}"
    FileUtils.cd GIT_TARGET_PATH do
      system "git stash && git pull origin master && git stash pop"
    end

    FileUtils.cd GIT_TARGET_PATH do
      result = `rake`
      expect(result).to include("Mountains are again merely mountains"), "You did not finish all the koans yet."
      expect(result).to_not include("meditate on the following code"), "You did not finish all the koans yet."
    end
  end
end
