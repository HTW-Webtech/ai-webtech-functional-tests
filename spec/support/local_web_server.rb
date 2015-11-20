module LocalWebServer
  module_function

  def setup(port:, server_root_path:, config:)
    config.after :all do
      if self.respond_to?(:page) && page.driver.browser.respond_to?(:close)
        page.driver.browser.close
      end
    end

    config.before :suite do
      puts "Bringing up local webserver on port #{port}"
      $SERVER_PID = fork do
        FileUtils.cd server_root_path do
          exec "ruby -run -e httpd . -p #{port}"
        end
      end

      at_exit do
        puts "Bringing down local webserver"
        Process.kill 'TERM', $SERVER_PID
        Process.wait $SERVER_PID
      end
    end
  end
end
