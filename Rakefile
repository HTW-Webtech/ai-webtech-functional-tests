# Usage
# run `rake exercise:dev`  for dev reporting
# run `rake exercise:prod` for prod reporting
# run `rake` to spec this code

require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec_lib) do |c|
  c.pattern = "spec/lib/**/*_spec.rb"
  c.verbose = false
end

RSpec::Core::RakeTask.new(:spec_exercises) do |c|
  c.pattern = "spec/exercises/exercise_#{ENV['EXERCISE_ID']}_spec.rb"
  c.verbose = false
end

namespace :test do
  task run_and_report: ['spec', 'test:report']

  desc 'Run tests with a real google chrome browser'
  task :dev do
    ENV['TEST_ENV'] = 'development'
    Rake::Task['test:run_and_report'].invoke
  end

  desc 'Run tests with a headless phantomjs'
  task prod: ['ci:setup:rspec', 'test:run_and_report']

  desc 'Post report for test to exercise service'
  task :report do
    TestReporter.run
  end
end

task default: 'spec_lib'
