require "spec_helper"

describe Project do
  before(:each) do
    @project = Project.create(:name => "Default project")
    @project.fails.create()
    @project.fails.create(:resolved => true)
  end
  
  
  describe "fail access" do
    it "should only return non-acked fails when asked for open ones" do
      fails = @project.open_fails
      fails.size.should == 1
    end
  end
  
  it "should create api key for project" do
    @project.api_key.should_not be_nil
  end

  it "should split comma separated list of email notification recipients into array of unique recipients" do
    quentin = "quentin@tarantino.com"
    aaron   = "aaron@carter.org"
    ben     = "ben@penny.org"

    lambda {
      @project.email_notification_recipients_str = "#{quentin}, #{aaron},#{ben},  #{quentin}"
    }.should change(@project, :email_notification_recipients).from([]).to(
      [quentin, aaron, ben]
    )
  end
  
end
