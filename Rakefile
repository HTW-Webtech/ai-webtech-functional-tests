require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require 'byebug'
require_relative 'lib/test_reporter'

RSpec::Core::RakeTask.new(:spec_lib) do |c|
  c.pattern = "spec/lib/**/*_spec.rb"
  c.verbose = false
end

RSpec::Core::RakeTask.new(:spec_exercises) do |c|
  c.pattern = "spec/exercises/exercise_#{ENV['EXERCISE_ID']}_spec.rb"
  c.verbose = false
end

namespace :exercise do
  task run_and_report: ['spec_exercises', 'exercise:report']

  desc 'Run tests with a real google chrome browser'
  task :dev do
    ENV['TEST_ENV'] = 'development'
    Rake::Task['exercise:run_and_report'].invoke
  end

  desc 'Run tests with a headless phantomjs'
  task prod: ['ci:setup:rspec', 'exercise:run_and_report']

  desc 'Post report for test to exercise service'
  task :report do
    TestReporter.run
  end
end

task default: 'spec_lib'
