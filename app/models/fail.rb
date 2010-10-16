class Fail
  include Mongoid::Document
  
  field :occured_at, :type => DateTime
  field :title, :type => String
  field :data, :type => Array
  
  embeds_many :occurences, :class_name => "Fail"
  referenced_in :project
end