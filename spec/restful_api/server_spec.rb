require "spec_helper"

describe "RESTful API" do
  include Rack::Test::Methods
  
  before(:each) do
    @project = Project.create(:name => "Default project")
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

    it "should create a new Fail for each report in post" do
      lambda {
        do_valid_post_with_two
      }.should change(Fail, :count).by(2)
    end
    
    it "should respond with Bad Request when the data is invalid" do
      do_invalid_post
      last_response.status.should == 400
    end
    
    def do_valid_post
      post "/api/projects/#{@project.api_key}/fails", valid_data
    end

    def do_valid_post_with_two
      post "/api/projects/#{@project.api_key}/fails", "[#{valid_data("NoMethodError")},#{valid_data("NilFail")}]"
    end
    
    def valid_data(exception = "NoMethodError")
      "{\"title\":\"Moi\",\"data\":[[\"summary\",[[\"type\",\"#{exception}\",{\"use_in_checksum\":true}]]]]}"
    end
    
    def do_invalid_post
      post "/api/projects/#{@project.api_key}/fails", "{\"title\"\"Moi\",\"data\":[[\"summary\",[[\"type\",\"NoMethodError\",{\"use_in_checksum\":true}]]]]}"
    end
  end
end
