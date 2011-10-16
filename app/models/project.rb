class Project
  include Mongoid::Document
  field :name, type: String
  field :api_key, type: String
  index :api_key, unique: true

  before_create :generate_api_key

  protected

    def generate_api_key
      self.api_key = UUID.new.generate.to_s
    end
end
