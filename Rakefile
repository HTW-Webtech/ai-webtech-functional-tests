require 'rspec/core/rake_task'
require_relative 'lib/test_reporter'

RSpec::Core::RakeTask.new(:spec_lib) do |c|
  c.pattern = "spec/lib/**/*_spec.rb"
  c.verbose = false
end

RSpec::Core::RakeTask.new(:spec_exercises) do |c|
  spec_file = File.expand_path("../spec/exercises/#{ENV.fetch('EXERCISE_NAME')}_spec.rb", __FILE__)
  fail "There is no spec for this exercise" unless File.exists? spec_file
  c.pattern = spec_file
  c.verbose = false
end

namespace :exercise do
  task run_and_report: ['spec_exercises', 'exercise:report']
  task :ci_reporter do
    require 'ci/reporter/rake/rspec'
    Rake::Task['ci:setup:rspec'].invoke
  end

  desc 'Run tests with a real google chrome browser'
  task dev: [:ci_reporter] do
    Rake::Task['exercise:run_and_report'].invoke
  end

  desc 'Run tests with a headless phantomjs'
  task prd: [:ci_reporter] do
    Rake::Task['exercise:run_and_report'].invoke
  end

  desc 'Post report for test to exercise service'
  task :report do
    tests_env = ENV.fetch('TESTS_ENV')
    ComplexConfig.configure do |config|
      config.env = tests_env
    end

    if tests_env != 'development'
      app_name    = ENV.fetch('APP_NAME')
      exercise_id = ENV.fetch('EXERCISE_ID')
      TestReporter.run(app_name: app_name, exercise_id: exercise_id)
    end
  end
end

task default: 'spec_lib'
