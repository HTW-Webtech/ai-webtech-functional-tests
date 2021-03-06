describe 'Ruby Exercise' do
  GIT_REPO_PATH   = "/var/apps/#{$APP_NAME}/code"
  GIT_TARGET_PATH = File.expand_path("../vendor/ruby_koans_code", __FILE__)

  it 'runs all koans successfully' do
    system "test -e #{GIT_TARGET_PATH} || git clone #{GIT_REPO_PATH} #{GIT_TARGET_PATH}"

    FileUtils.cd GIT_TARGET_PATH do
      puts "PWD: #{`pwd`.chomp}"
      system "git reset HEAD --hard && git pull origin master"
    end

    File.exists? "#{GIT_TARGET_PATH}/Rakefile" or fail("Das git Repository enthält kein Rakefile, dass zur Übung gehört. Sind wirklich alle Änderungen auf dem Aris-Server?")
    FileUtils.cd GIT_TARGET_PATH do
      result = `rake`
      expect(result).to include("Mountains are again merely mountains"), "You did not finish all the koans yet."
      expect(result).to_not include("meditate on the following code"), "You did not finish all the koans yet."
    end
  end
end
