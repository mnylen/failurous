class FailSection
  include Mongoid::Document
  field :title, type: String
  embedded_in :fail_occurrence

  embeds_many :fail_fields
end
