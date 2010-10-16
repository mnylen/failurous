class Project
  include Mongoid::Document
  
  field :name, :type => String
  references_many :fails, :default_order => :occured_at.desc
end
