class Project
  include Mongoid::Document

  validates_presence_of :name
  validates_uniqueness_of :name

  field :name, :type => String
  field :api_key, :type => String, :index => true
  field :email_notification_recipients, :type => Array
  
  references_many :fails, :default_order => :last_occurence_at.desc
  
  attr_protected :api_key
  
  before_create :assign_api_key

  set_callback(:initialize, :after) do |document|
    document.email_notification_recipients = []
  end

  def email_notification_recipients_str
    self.email_notification_recipients.join(", ")
  end

  def email_notification_recipients_str=(str)
    recipients = str.split(",")
    self.email_notification_recipients = recipients.map { |r| r.strip }.uniq

    str
  end
  
  def open_fails
    fails.where(:resolved.ne => true)
  end

  def closed_fails
    fails.where(:resolved => true)
  end
  
  def last_open_fail
    open_fails.last
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

