require "spec_helper"

describe "RESTful API" do
  include Rack::Test::Methods
  
  before(:each) do
    Project.create(:name => "Default project")
  end
  
  def app
    @app ||= Sinatra::Application
  end
  
  describe "POST /api/projects/:api_key/fails" do
    it "should respond with OK when everything went well" do
      do_valid_post
      last_response.should be_ok
    end
    
    it "should create a new Fail" do
      lambda {
        do_valid_post
      }.should change(Fail, :count).by(1)
    end
    
    it "should respond with Bad Request when the data is invalid" do
      do_invalid_post
      last_response.status.should == 400
    end
    
    def do_valid_post
      post '/api/projects/394949/fails', :data => "{\"title\":\"Moi\",\"data\":[[\"summary\",[[\"type\",\"NoMethodError\",{\"use_in_checksum\":true}]]]]}"
    end
    
    def do_invalid_post
      post '/api/projects/394949/fails', :data => "{\"title\"\"Moi\",\"data\":[[\"summary\",[[\"type\",\"NoMethodError\",{\"use_in_checksum\":true}]]]]}"
    end
  end
end