class Fail
  include Mongoid::Document
  field :title, type: String
  field :location, type: String

  belongs_to :project, index: true
end
