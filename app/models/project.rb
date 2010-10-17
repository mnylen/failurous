class Project
  include Mongoid::Document

  validates_presence_of :name
  validates_uniqueness_of :name

  field :name, :type => String
  field :api_key, :type => String, :index => true
  
  references_many :fails, :default_order => :last_occurence_at.desc
  
  attr_protected :api_key
  
  before_create :assign_api_key
  
  def open_fails
    fails.where(:acknowledged.ne => true)
  end

  def closed_fails
    fails.where(:acknowledged => true)
  end
  
  def has_open_fails?
    not self.open_fails.empty?
  end

  def has_closed_fails?
    not self.closed_fails.empy?
  end

  def has_fails?
    not fails.empty?
  end

  private
  
    def assign_api_key
      self.api_key = UUIDTools::UUID.random_create.to_s
    end
  
end

