# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require ::File.expand_path('../lib/failurous/restful_api/server', __FILE__)

run Rack::Builder.new {
  run Rack::Cascade.new([Failurous::Application, Sinatra::Application])
}