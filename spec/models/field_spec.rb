require "spec_helper"

describe Section do
  
  before(:each) do
    @field = Field.new([:last_stack_frame, "from ipsum:10:in `lorem'", {:use_in_checksum => true}])    
    @field_without_attrs = Field.new([:last_stack_frame, "from ipsum:10:in `lorem'"])
  end
  
  
  describe "construction" do
    
    it "should use the first item stringified as key" do
      @field.key.should == "last_stack_frame"
    end
    
    it "should use the second item as value" do
      @field.value.should == "from ipsum:10:in `lorem'"
    end

    it "should unescape double-escaped control characters" do
      f = Field.new([:full_backtrace, "a\\nb"])
      f.value.should == "a\nb"
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
  
  describe "backtrace detection" do
    
    it "should know when it's a backtrace and when it isn't" do
      Field.new([:last_stack_frame, ""]).should be_a_backtrace
      Field.new([:full_backtrace, ""]).should be_a_backtrace
      Field.new([:stacktrace, ""]).should be_a_backtrace
      Field.new([:stack_trace, ""]).should be_a_backtrace

      Field.new([:whatever, ""]).should_not be_a_backtrace
      Field.new([:back_door, ""]).should_not be_a_backtrace      
    end
    
  end
  
end

