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

  describe "calculate_checksum_from_notification" do

    context "using title in checksum" do
      it "should use title in checksum if notification[:use_title_in_checksum] == true" do
        title_checksum("lorem").should_not == title_checksum("ipsum")
      end

      it "should not use title in checksum if notification[:use_title_in_checksum] == false" do
        title_checksum("lorem", false).should == title_checksum("ipsum", false)
      end

      def title_checksum(title, use_in_checksum = true)
        Fail.calculate_checksum_from_notification({:title => title, :use_title_in_checksum => use_in_checksum})
      end
    end


    context "using location in checksum" do
      it "should use location in checksum by default" do
        location_checksum("heaven#show").should_not == location_checksum("heaven#fall")
      end

      it "should not use location in checksum when notification[:use_location_in_checksum] == false" do
        location_checksum("heaven#show", false).should == location_checksum("heaven#fall", false)
      end

      def location_checksum(location, use_in_checksum = true)
        notification = {:location => location}
        notification[:use_location_in_checksum] = false unless use_in_checksum
        Fail.calculate_checksum_from_notification(notification)
      end
    end


    context "using field values in checksum" do
      it "should use the field value in checksum if options[:use_in_checksum] == true" do
        x = field_checksum(:summary, :type, "NoMethodError")
        y = field_checksum(:summary, :type, "ActionController::RoutingError")
        x.should_not == y
      end

      it "should use the field name in checksum if options[:use_in_checksum] == true" do
        x = field_checksum(:summary, :type, "NoMethodError")
        y = field_checksum(:summary, :message, "NoMethodError")
        x.should_not == y
      end

      it "should use the section name in checksum if options[:use_in_checksum] == true" do
        x = field_checksum(:summary, :type, "NoMethodError")
        y = field_checksum(:details, :type, "NoMethodError")
        x.should_not == y
      end


      it "should not use the field value in checksum if options[:use_in_checksum] == false" do
        x = field_checksum(:summary, :type, "NoMethodError", false)
        y = field_checksum(:summary, :type, "ActionController::RoutingError", false)
        x.should == y
      end

      it "should not use the field name in checksum if options[:use_in_checksum] == false" do
        x = field_checksum(:summary, :type, "NoMethodError", false)
        y = field_checksum(:summary, :message, "NoMethodError", false)
        x.should == y
      end

      it "should not use the section name in checksum if options[:use_in_checksum] == false" do
        x = field_checksum(:summary, :type, "NoMethodError", false)
        y = field_checksum(:details, :type, "NoMethodError", false)
        x.should == y
      end


      def field_checksum(section_name, field_name, value, use_in_checksum = true)
        notification = {:data => [ [section_name, [ [field_name, value, {:use_in_checksum => use_in_checksum}] ] ] ]}
        Fail.calculate_checksum_from_notification(notification)
      end
    end
  end

  describe "create_or_combine_with_similar_fail" do
    
    it "should create a new fail when there's no other fails in the database" do
      lambda { Fail.create_or_combine_with_similar_fail(@project, @attributes) }.should change(Fail, :count).by(1)
    end

    it "should create a new occurence for the fail" do
      Fail.create_or_combine_with_similar_fail(@project, @attributes).occurences.size.should == 1
    end

    it "should combine fails in same project that have the same checksum" do
      Fail.create_or_combine_with_similar_fail(@project, @attributes)
      lambda { Fail.create_or_combine_with_similar_fail(@project, @attributes) }.should_not change(Fail, :count)
    end

    it "should add a new occurence for the existing fail" do
      Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)

      fail.occurences.count.should == 2
    end

    it "should not combine fails in different projects that have the same checksum" do
      another_project = Project.create(:name => "Shatner's Bassoon Inc")
      Fail.create_or_combine_with_similar_fail(@project, @attributes)

      lambda { Fail.create_or_combine_with_similar_fail(another_project, @attributes) }.should change(Fail, :count).by(1)
    end

    it "should update 'next_occurence_id' on the previous occurence and 'previous_occurence_id' on the new occurence" do
      Fail.create_or_combine_with_similar_fail(@project, @attributes)
      fail = Fail.create_or_combine_with_similar_fail(@project, @attributes)

      fail.occurences.first.next_occurence_id.should == fail.occurences.last.id.to_s
      fail.occurences.last.previous_occurence_id.should == fail.occurences.first.id.to_s
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
