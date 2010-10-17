require 'sinatra'

post '/api/projects/:api_key/fails' do
  begin
    project = Project.where(:api_key => params[:api_key]).first
    data    = ActiveSupport::JSON.decode(params[:data])    
    Fail.create_or_combine_with_similar_fail(project, data)
    
    status 200
    "OK"
  rescue
    status 400
    "Bad Request"
  end
end

