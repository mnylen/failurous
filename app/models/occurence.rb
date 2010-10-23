class Occurence
  include Mongoid::Document
  
  embedded_in :fail, :inverse_of => :fails
  field :occured_at, :type => DateTime
  field :title, :type => String
  field :data, :type => Array
  field :next_occurence_id
  field :previous_occurence_id

  def sections
    (self[:data] || []).map { |section| Section.new(section) }
  end
  
end
