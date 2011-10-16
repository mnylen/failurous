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

  it "should have many occurrences with embedded sections and fields" do
    failurous = Project.create(name: "Failurous")
    a_fail = Fail.new(title: "FailError: Epic Fail", project: failurous)

    occurrence = FailOccurrence.new(occurred_at: Time.now, fail: a_fail)
    section = occurrence.fail_sections.build(title: "Summary")
    section.fail_fields.build(name: "Error type", value: "FailError", field_type: "string")
    section.fail_fields.build(name: "Error message", value: "Epic Fail", field_type: "string")

    a_fail.save!

    a_fail = Fail.find(a_fail.id)
    a_fail.fail_occurrences.size.should == 1

    occurrence = a_fail.fail_occurrences.first
    occurrence.fail_sections.size.should == 1

    section = occurrence.fail_sections.first
    section.fail_fields.size.should == 2
  end
end

