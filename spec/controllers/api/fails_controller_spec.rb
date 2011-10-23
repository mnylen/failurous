require "spec_helper"

describe Api::FailsController, "on POST to :create" do
  before(:each) do
    @api_key   = UUID.new.generate.to_s
    @fail_data = valid_fail_data.to_json
  end

  it "should respond with 401 UNAUTHORIZED if invalid api key was provided" do
    Project.should_receive(:by_api_key).with(@api_key).and_return(nil)
    post :create, :api_key => @api_key, :data => @fail_data

    response.status.should == 401 
    response.body.should == "Invalid API key provided\r\n"
  end

  it "should respond with 400 BAD REQUEST if fail data was not given" do
    Project.should_receive(:by_api_key).with(@api_key).and_return(mock())
    post :create, :api_key => @api_key

    response.status.should == 400 
    response.body.should == "Invalid or missing fail data\r\n"
  end

  it "should respond with 400 BAD REQUEST if fail data is invalid JSON" do
    Project.should_receive(:by_api_key).with(@api_key).and_return(mock())
    post :create, :api_key => @api_key, :fail_data => "{'invalid''json':'here'}"

    Fail.should_not_receive(:create_or_combine)

    response.status.should == 400
    response.body.should == "Invalid or missing fail data\r\n"
  end

  it "should respond with 201 CREATED and create or combine the fail" do
    project_mock = mock_model(Project) 
    Project.should_receive(:by_api_key).with(@api_key).and_return(project_mock)
    Fail.should_receive(:create_or_combine).with(project_mock, JSON.parse(@fail_data)).and_return(true)

    post :create, :api_key => @api_key, :data => @fail_data

    response.status.should == 201 
    response.body.should == "Fail created\r\n"
  end

  it "should respond with 400 BAD REQUEST if Fail#create_or_combine raises" do
    project_mock = mock_model(Project) 
    Project.should_receive(:by_api_key).with(@api_key).and_return(project_mock)
    Fail.should_receive(:create_or_combine).with(project_mock, JSON.parse(@fail_data)).and_raise("some error")

    post :create, :api_key => @api_key, :data => @fail_data

    response.status.should == 400 
    response.body.should == "Invalid or missing fail data\r\n"
  end
end
