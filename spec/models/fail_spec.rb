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

describe Fail, "combining" do
  before(:all) do
    @attributes = {
      title:    "FailError: Epic Fail",
      location: "fails#index",

      sections: [
        { title:  "Summary",
          fields: [
            { name:    "Error type",
              value:   "FailError",
              type:    "string",
              hidden:  false,
              combine: true
            },
            { name:    "Error message",
              value:   "Epic fail",
              type:    "string",
              hidden:  false,
              combine: false
            },
            { name:    "Top line in stack trace",
              value:   "somewhere/in/the/app.rb:30",
              type:    "string",
              hidden:  true,
              combine: true
            }
          ]
        },
        { title:  "User session",
          fields: [
            { name:    "Username",
              value:   "quentin",
              type:    "string"
            }
          ]
        }
      ]
    }
  end

  before(:each) do
    @project = Project.create(name: "Failurous")
  end

  it "should create fail for project" do
    Fail.create_or_combine(@project, @attributes)

    @project = Project.find(@project.id)
    @project.fails.count.should == 1
  end

  it "should combine two identical fails" do
    lambda { Fail.create_or_combine(@project, @attributes) }.should change(Fail, :count).by(1)
    lambda { Fail.create_or_combine(@project, @attributes) }.should_not change(Fail, :count)

    a_fail = Fail.first
    a_fail.fail_occurrences.size.should == 2
  end

  it "should combine only when all fields with combine: true are identical" do
    Fail.create_or_combine(@project, @attributes)

    modified_attributes = @attributes
    modified_attributes[:sections].first[:fields].first[:value] = "NonFailError"

    Fail.create_or_combine(@project, modified_attributes)

    Fail.count.should == 2
  end
end
