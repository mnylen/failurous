class Fail
  include Mongoid::Document
  
  field :checksum, :type => String
  field :last_occurence_at, :type => DateTime
  field :occurence_count, :type => Integer
  field :resolved, :type => Boolean
  field :title, :type => String
  field :location, :type => String
  
  embeds_many :occurences
  referenced_in :project
  
  def location
    self[:location] || "unspecified location"
  end
  
  def last_occurence
    self.occurences.last
  end
  
  def increase_count
    self.occurence_count ||= 0
    self.occurence_count += 1
  end
  
  def resolve!
    self.update_attributes!(:resolved => true)
  end
 

  def self.create_or_combine_with_similar_fail(project, attributes)
    attributes = HashWithIndifferentAccess.new(attributes)
    checksum   = calculate_checksum_from_notification(attributes)
    occurence  = Occurence.new(attributes.merge({:occured_at => Time.now}))
    
    fail = find_by_checksum_and_project_or_build_new(project, checksum) 
    send_email = (fail.new_record? || fail.resolved?) && project.email_notifications_enabled?
    update_fail_attributes(fail, occurence, attributes)

    if send_email
      Notifier.fail_landed(fail).deliver
    end

    fail
  end
  

  def self.calculate_checksum_from_notification(notification)
    md5 = Digest::MD5.new
    update_md5_with_title(md5, notification)
    update_md5_with_location(md5, notification)
    update_md5_with_fields(md5, notification)

    md5.hexdigest
  end

  private

    def self.update_md5_with_fields(md5, notification)
      data = notification[:data] || []
      data.each do |section|
        section_name, fields = section

        fields.each do |field|
          field_name, field_value, field_options = field
          field_options = HashWithIndifferentAccess.new(field_options)

          if field_options[:use_in_checksum]
            md5.update("#{section_name}##{field_name}##{field_value}")
          end
        end
      end
    end

    def self.update_md5_with_title(md5, notification)
      if notification[:use_title_in_checksum] and notification[:title]
        md5.update("title##{notification[:title]}")
      end
    end

    def self.update_md5_with_location(md5, notification)
      if notification[:use_location_in_checksum] != false
        md5.update("location##{notification[:location]}") if notification[:location]
      end
    end

    def self.update_fail_attributes(fail, new_occurence, attributes)
      fail.title = attributes[:title]
      fail.last_occurence_at = Time.now 
      fail.increase_count
      fail.resolved = false
      fail.location = attributes[:location]

      if fail.occurences.last
        new_occurence.previous_occurence_id = fail.occurences.last.id
        fail.occurences.last.next_occurence_id = new_occurence.id
      end

      fail.occurences << new_occurence
      fail.save
    end

    def self.find_by_checksum_and_project_or_build_new(project, checksum)
      fail = Fail.where(:project_id => project.id, :checksum => checksum).first
      unless fail
        fail = Fail.new(:project_id => project.id, :checksum => checksum)
      end

      fail
    end

  
end

