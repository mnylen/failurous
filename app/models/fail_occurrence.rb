class FailOccurrence
  include Mongoid::Document
  belongs_to :fail, index: true

  field :occurred_at, type: DateTime, default: -> { Time.now }

  embeds_many :fail_sections

  def self.from_notification(notification)
    notification = HashWithIndifferentAccess.new(notification)
    occurrence   = FailOccurrence.new()

    (notification["sections"] || []).each do |section_data|
      section = FailSection.new(title: section_data["title"])

      (section_data["fields"] || []).each do |field_data|
        field = FailField.new(name: field_data["name"], value: field_data["value"])

        if field_data[:hidden]
          field.hidden = field_data[:hidden]
        end

        if field_data[:combine]
          field.combine = field_data[:combine]
        end

        if field_data[:type]
          field.field_type = field_data[:type]
        end

        section.fail_fields << field
      end

      occurrence.fail_sections << section
    end

    occurrence
  end
end
