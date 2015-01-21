require 'dotenv'; Dotenv.load
require 'codeclimate-test-reporter'; CodeClimate::TestReporter.start
require 'xbox-api'
require 'vcr'
require 'webmock'
require 'vcr'


RSpec.configure do |config|
  # config.run_all_when_everything_filtered = true
  # config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  # config.order = 'random'
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :webmock
  config.ignore_hosts 'codeclimate.com'
end
