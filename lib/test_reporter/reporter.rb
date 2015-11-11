require 'typhoeus'
require 'json'
require 'complex_config/rude'

module TestReporter
  class Reporter
    class << self
      def report(report)
        new(report).post
      end
    end

    attr_reader :report

    def initialize(report)
      @report = report
    end

    def url
      tpl = cc(:site).api_uri_template
      tpl.gsub('{app_name}', report[:app_name].to_s).
          gsub('{exercise_id}', report[:exercise_id].to_s)
    end

    def body
      JSON.generate({ report: report })
    end

    def headers
      {
        'x-created-with' => 'test-reporter'
      }
    end

    def post
      Typhoeus.post(url, body: body, headers: headers)
    end
  end
end

