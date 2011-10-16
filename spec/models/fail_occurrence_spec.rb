require "spec_helper"

describe FailOccurrence, "building from notification" do
  before(:all) do
    @attributes = {
      sections: [
        { title:  "Summary",
          fields: [
            { name:    "Error type",
              value:   "FailError",
              combine: true
            },
            { name:    "Error message",
              value:   "Epic Fail"
            }
          ]
        },
        { title:  "Epicness",
          fields: [
            { name:    "Fail",
              value:   "true",
              type:    "boolean",
              combine: false,
              hidden:  true
            }
          ]
        }
      ]
    }
  end

  before(:each) do
    @occurrence = FailOccurrence.from_notification(@attributes)
  end

  it "should create section for each item in sections" do
    @occurrence.fail_sections.size.should == 2
    @occurrence.fail_sections.map(&:title).should == ["Summary", "Epicness"]
  end

  it "should create field for each field in each section's fields" do
    summary = @occurrence.fail_sections.first
    summary.fail_fields.size.should == 2
    summary.fail_fields.map(&:name).should == ["Error type", "Error message"]
    summary.fail_fields.map(&:value).should == ["FailError", "Epic Fail"]
    summary.fail_fields.map(&:combine?).should == [true, false]
    summary.fail_fields.map(&:hidden?).should == [false, false]
    summary.fail_fields.map(&:field_type).should == ["string", "string"]

    epicness = @occurrence.fail_sections.last
    epicness.fail_fields.size.should == 1
    epicness.fail_fields.map(&:name).should == ["Fail"]
    epicness.fail_fields.map(&:value).should == ["true"]
    epicness.fail_fields.map(&:combine).should == [false]
    epicness.fail_fields.map(&:hidden).should == [true]
    epicness.fail_fields.map(&:field_type).should == ["boolean"]
  end
end
