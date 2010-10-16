require "spec_helper"

describe Fail do
  before(:each) do
    @project = Project.create(:name => "Default project")
    
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
  
  
  describe "create_new_or_combine_with_similar_fail" do
    it "should create new when there's no other fails in the db" do
      lambda {
        Fail.create_or_combine_with_similar_fail(@project, @attributes)
      }.should change(Fail, :count).by(1)
    end
    
    it "should set last_occurence_at to the current date and time for the fail" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail.last_occurence_at.should_not be_nil
    end
    
    it "should create and store occurence for the fail" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail.occurences.size.should == 1
    end
    
    it "should combine to previous fail if the checksums match" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      lambda {
        Fail.create_or_combine_with_similar_fail(@project, @attributes)
      }.should_not change(Fail, :count)
      
      fail = Fail.find(fail.id)
      fail.occurences.size.should == 2
    end
  end
  
  describe "title" do
    it "should be the title of the first occurence" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      Fail.create_or_combine_with_similar_fail(@project, @attributes.merge(:title => "Hello"))
      fail.title.should == "Test"
    end
  end
  
  describe "sections" do
    it "should return a section for each item in the data array" do
      fail = Fail.new(@attributes)
      sections = fail.sections
      sections.size.should == 2
      sections.first.should be_a(Section) 
    end   
  end 
  
end
