class Fail
  include Mongoid::Document
  field :title, type: String
  field :location, type: String
  field :combine_key, type: String

  belongs_to :project, index: true
  has_many :fail_occurrences, autosave: true 

  def self.create_or_combine(project, notification)
    notification = HashWithIndifferentAccess.new(notification)
    occurrence   = FailOccurrence.from_notification(notification)
    combine_key  = calculate_combine_key(occurrence)
    the_fail     = Fail.in_project_and_combined_by(project, combine_key) || Fail.new

    if the_fail.new_record? 
      the_fail.title = notification["title"]
      the_fail.location = notification["location"]
      the_fail.combine_key = combine_key
    end

    the_fail.project = project
    the_fail.fail_occurrences << occurrence
    the_fail.save!

    the_fail
  end

  def self.in_project(project)
    where(project_id: project.id)
  end

  def self.combined_by(combine_key)
    where(combine_key: combine_key)
  end

  def self.in_project_and_combined_by(project, combine_key)
    in_project(project).combined_by(combine_key).first
  end

  private

    def self.calculate_combine_key(occurrence)
      md5 = ::Digest::MD5.new

      occurrence.fail_sections.each do |section|
        section.fail_fields.each do |field|
          md5.update("#{section.title}###{field.name}##{field.value}") if field.combine?
        end
      end

      md5.hexdigest
    end
end
