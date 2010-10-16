class Project
  include Mongoid::Document
  
  field :name, :type => String
  references_many :fails, :default_order => :last_occurence_at.desc
  
  def open_fails
    fails.where(:acknowledged.ne => true)
  end
  
end

