require "spec_helper"

describe Section do
  
  before(:each) do
    @field = Field.new([:last_stack_frame, "from ipsum:10:in `lorem'", {:use_in_checksum => true}])    
    @field_without_attrs = Field.new([:last_stack_frame, "from ipsum:10:in `lorem'"])
  end
  
  
  describe "construction" do
    
    it "should use the first item as key" do
      @field.key.should == :last_stack_frame
    end
    
    it "should use the second item as value" do
      @field.value.should == "from ipsum:10:in `lorem'"
    end
    
    it "should give access to the third hash as attributes" do
      @field[:use_in_checksum].should == true
    end
    
    it "should return nils for attributes if no third hash was given" do
      @field[:whatever].should be_nil
    end
 
  end
  
  describe "humanization" do
    
    it "should humanize and capitalize the key for the title" do
      @field.title.should == "Last stack frame"
    end
    
  end
  
end

