class Project
  include Mongoid::Document
  
  field :name, :type => String
  
  references_many :fails
end