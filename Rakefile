require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |c|
  c.pattern = "spec/exercises/exercise_#{ENV['EXERCISE_ID']}_spec.rb"
  c.verbose = false
end

namespace :test do
  desc 'Run tests with a real google chrome browser'
  task :dev do
    ENV['TEST_ENV'] = 'development'
    Rake::Task['test:prod'].invoke
  end

  desc 'Run tests with a headless phantomjs'
  task prod: ['ci:setup:rspec', 'spec']

  desc 'Post report for test to exercise service'
  task :report do
    TestReporter.run
  end
end

task default: 'test:prod'
