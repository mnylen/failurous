class Project
  include Mongoid::Document
  
  field :name, :type => String
  references_many :fails, :default_order => :last_occurence_at.desc
end
