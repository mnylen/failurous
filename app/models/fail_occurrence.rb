class FailOccurrence
  include Mongoid::Document
  belongs_to :fail, index: true

  field :occurred_at, type: DateTime

  embeds_many :fail_sections
end
