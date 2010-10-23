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
          [:stack_trace, "Lorem ipsum dolor sit amet", {:use_in_checksum => false}]
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
    
    it "should increase the count" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail.occurence_count.should == 1
      
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail.occurence_count.should == 2
    end
  end
  
  describe "title" do
    it "should be the title of the first occurence" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      Fail.create_or_combine_with_similar_fail(@project, @attributes.merge(:title => "Hello"))
      fail.title.should == "Test"
    end
  end
  
  describe "acknowledgments" do
    
    it "should be acknowledged after ack has been called" do
      fail = @project.fails.create(@attributes)
      fail.ack!
      Fail.find(fail.id).should be_acknowledged   
    end
    
    it "should not be acknowledged after a new occurrence" do
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail.ack!     
      Fail.create_or_combine_with_similar_fail(@project, @attributes)
      Fail.find(fail.id).should_not be_acknowledged      
    end
    
  end
end
