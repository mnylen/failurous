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
