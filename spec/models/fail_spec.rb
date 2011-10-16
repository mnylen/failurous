require "spec_helper"

describe Fail, "relations" do
  it "should belong to project" do
    failurous = Project.create(name: "Failurous")
    a_fail    = Fail.create(title: "FailError: Epic Fail", project: failurous)

    failurous = Project.find(failurous.id)
    failurous.fails.should include(a_fail)
    
    a_fail = Fail.find(a_fail.id)
    a_fail.project.should == failurous

    another_project = Project.create(name: "Fail-O-Project")
    another_project.fails.should be_empty
  end
end
