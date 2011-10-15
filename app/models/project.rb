class Project
  include Mongoid::Document

  field :name, type: String
  field :api_key, type: String
end
