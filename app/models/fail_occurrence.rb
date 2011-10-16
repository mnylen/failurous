class FailOccurrence
  include Mongoid::Document
  belongs_to :fail, index: true

  field :occurred_at, type: DateTime

  embeds_many :fail_sections

  def self.from_notification(notification)
    occurrence = FailOccurrence.new()

    (notification["sections"] || []).each do |section_data|
      section = FailSection.new(title: section_data["title"])

      (section_data["fields"] || []).each do |field_data|
        section.fail_fields.build({
          name:       field_data["name"],
          value:      field_data["value"],
          field_type: field_data["type"],
          hidden:     field_data["hidden"],
          combine:    field_data["combine"]
        })
      end

      occurrence.fail_sections << section
    end

    occurrence
  end
end
