class FailField
  DEFAULT_TYPE = "string"

  include Mongoid::Document
  embedded_in :section

  field :name, type: String
  field :value, type: String
  field :field_type, type: String, default: DEFAULT_TYPE
  field :hidden, type: Boolean, default: false
  field :combine, type: Boolean, default: false

  validates_presence_of :name, :value
end
