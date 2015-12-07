require 'typhoeus'
require 'json'
require 'complex_config/rude'

module TestReporter
  class Reporter
    attr_reader :report

    def initialize(report)
      @report = report
    end

    def sent_report
      puts "Delivering #{body},\nheaders: #{headers}\nto #{url}" if ENV['VERBOSE']
      response = Typhoeus.post(url, body: body, headers: headers)
      raise RuntimeError, <<-EOF unless response.code == 200
=======
Report could not be delivered.
Response-Code: #{response.code}
Response-Body:\n#{response.body}\n
Request-URL: #{response.request.url}
Request-Options:\n#{response.request.original_options}
=======
EOF
    end

    def url
      tpl = cc(:site).api_uri_template
      tpl.gsub('{app_name}', report[:app_name].to_s).
          gsub('{exercise_id}', report[:exercise_id].to_s)
    end

    def body
      JSON.generate({ exercise_result: report })
    end

    def headers
      {
        'Content-Type'   => 'application/json',
        'x-created-with' => 'test-reporter'
      }
    end
  end
end

