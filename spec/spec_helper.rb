# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require File.expand_path("../../config/environment", __FILE__)
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '.vendor/'
  add_filter 'spec/'
  add_filter 'lib/distribot*'
  add_filter 'lib/redis_model*'
end
SimpleCov.minimum_coverage 97
require 'rspec/rails'
require 'webmock/rspec'
require 'factory_girl_rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before :suite do
    WebMock.enable!
    WebMock.disable_net_connect!(
      :allow_localhost => false,
      :allow => 'codeclimate.com'
    )
  end
  config.before(:each) do
  end
  config.after(:each) do
  end

  config.before(:suite) do
    User.delete_all
  end
  config.before(:each) do
    User.delete_all
  end
  config.after(:each) do
    User.delete_all
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    # Allow foo.should syntax:
    expectations.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
    mocks.verify_partial_doubles = true
  end
end
