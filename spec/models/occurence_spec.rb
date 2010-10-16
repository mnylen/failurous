require "spec_helper"

describe Occurence do
  before(:each) do
    @attributes = {
      :title => "Test",
      :data  => [
        [:summary, [
          [:type, "NoMethodError", {:use_in_checksum => true}],
          [:message, "Called `id' for nil:NilClass", {:use_in_checksum => true}],
          [:environment, "production", {:use_in_checksum => true}],
          [:last_stack_frame, "from ipsum:10:in `lorem'", {:use_in_checksum => true}]
        ]],
        [:info, [
          [:stack_trace, ["Lorem ipsum dolor sit amet", {:use_in_checksum => false}]]
        ]]
      ]
    }
  end
  
  describe "sections" do
    it "should return a section for each item in the data array" do
      fail = Occurence.new(@attributes)
      sections = fail.sections
      sections.size.should == 2
      sections.first.should be_a(Section) 
    end   
  end 
  
end
