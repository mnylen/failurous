require "spec_helper"

describe Section do
  
  before(:each) do
    @section = Section.new(
        [:summary, [
          [:type, "NoMethodError", {:use_in_checksum => true}],
          [:message, "Called `id' for nil:NilClass", {:use_in_checksum => true}],
          [:environment, "production", {:use_in_checksum => true}],
          [:last_stack_frame, "from ipsum:10:in `lorem'", {:use_in_checksum => true}]
        ]])
  end
  
  
  describe "construction" do
    
    it "should use the first item as key" do
      @section.key.should == :summary
    end
    
    it "should return a field for each item in the second item" do
      @section.fields.size.should == 4
      @section.fields.first.should be_a Field
    end
 
  end
  
  describe "humanization" do
    
    it "should humanize and capitalize the key for the title" do
      @section.title.should == "Summary"
    end
    
  end
  
end

