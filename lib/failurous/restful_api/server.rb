require 'sinatra'

post '/api/projects/:api_key/fails' do
  "MOROOOOOOO, #{params[:api_key]}"  
end
