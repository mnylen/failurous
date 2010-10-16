require 'rubygems'
require 'bundler'
Bundler.setup(:default, :api)

require 'sinatra'

get '/api/hello' do
  "Hello, World!"
end