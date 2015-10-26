require 'typhoeus'

module TestReporter
  class Reporter
    def self.report(reports)
      reports.each do |report|
        new(report).post
      end
    end

    def initialize(report)
      @report = report
    end

    def url
      # TODO
      # - exercise url
      # admin.htw-webtech.com/api-v1/exercise_results/:app_name/:exercise_id.:format
      # admin.htw-webtech.com/api-v1/exercise_results/:app_name/:exercise_id.:format
    end

    def body
      { report: report }
    end

    def headers
      # TODO:
      # - Add signed cipher header
      {
      }
    end

    def post
      Typhoeus.post(url, body: body, headers: headers)
    end
  end
end

