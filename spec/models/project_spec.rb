require "spec_helper"

describe Project, "creation" do
  it "should generate unique api key for each project" do
    project = Project.create(name: "Failurous")
    project.api_key.should be_a(String)

    another = Project.create(name: "Bookmarks")
    another.api_key.should be_a(String)
    another.api_key.should_not == project.api_key
  end
end

describe Project, "validations" do
  before(:all) do
    @valid_attributes = { name: "Failurous" }
  end

  it "should be valid with valid attributes" do
    project = Project.new(@valid_attributes)
    project.should be_valid
  end

  it "should validate presence of name" do
    project = Project.new(@valid_attributes.merge(name: ""))
    project.should_not be_valid
    project.errors[:name].should_not be_empty
  end
end
