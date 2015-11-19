require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require_relative 'lib/test_reporter'
require 'complex_config/rude'

ComplexConfig.configure do |config|
  config.env = ENV['TESTS_ENV'] || 'development'
end

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
  task dev: ['ci:setup:rspec'] do
    Rake::Task['exercise:run_and_report'].invoke
  end

  desc 'Run tests with a headless phantomjs'
  task prd: ['ci:setup:rspec'] do
    Rake::Task['exercise:run_and_report'].invoke
  end

  desc 'Post report for test to exercise service'
  task :report do
    TestReporter.run
  end
end

task default: 'spec_lib'
