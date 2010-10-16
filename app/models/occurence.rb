class Occurence
  include Mongoid::Document
  
  embedded_in :fail, :inverse_of => :fails
  field :occured_at, :type => DateTime
  field :title, :type => String
  field :data, :type => Array
  
  def sections
    (self[:data] || []).map { |section| Section.new(section) }
  end
  
end
