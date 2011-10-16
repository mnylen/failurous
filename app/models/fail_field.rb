class FailField
  include Mongoid::Document
  embedded_in :section

  field :name, type: String
  field :value, type: String
  field :field_type, type: String
  field :hidden, type: Boolean
end
