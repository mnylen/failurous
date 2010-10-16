ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rack/test'
require "sinatra"
require File.join(File.dirname(__FILE__), '..', 'lib', 'failurous', 'restful_api', 'server')

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.mock_with :rspec
  
  config.before(:each) do
    Project.delete_all
    Fail.delete_all

  end
end
