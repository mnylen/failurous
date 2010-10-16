class Fail
  include Mongoid::Document
  
  field :checksum, :type => String
  field :last_occurence_at, :type => DateTime
  field :occurence_count, :type => Integer
  field :title, :type => String
  
  embeds_many :occurences
  referenced_in :project
  
  # Builds a new Occurence from the attributes and tries to combine
  # it with an existing Fail
  def self.create_or_combine_with_similar_fail(project, attributes)
    now        = Time.now
    attributes = HashWithIndifferentAccess.new(attributes)
    checksum   = calculate_checksum(attributes[:data])
    occurence  = Occurence.new(attributes) do |occurence|
      occurence.occured_at = now
    end
    
    fail = Fail.where(:checksum => checksum).first || Fail.create(:project_id => project.id, :title => attributes[:title], :checksum => checksum)
    fail.occurences << occurence
    fail.last_occurence_at = now
    fail.save
        
    fail
  end
  
  
  private
    
    def self.calculate_checksum(data)
      md5 = Digest::MD5.new
      
      data.each do |section|
        section[1].each do |field|
          options = HashWithIndifferentAccess.new(field[2])
          md5.update(field[1]) if options[:use_in_checksum]
        end
      end
      
      md5.hexdigest
    end
end