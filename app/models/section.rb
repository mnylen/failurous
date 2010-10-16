class Section
  
  attr_reader :key, :fields
  
  def initialize(data)
    @key = data.first
    @fields = data.second.map { |field| Field.new(field) }
  end
  
  def title
    @key.to_s.humanize
  end
  
end

