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
      puts "Delivering #{body},][3\n\nheaders: #{headers}\n\nto #{url}" if ENV['VERBOSE']
      Typhoeus.post(url, body: body, headers: headers)
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

