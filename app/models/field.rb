class Field
  
  attr_reader :key, :value
  
  def initialize(data)
    @key, @value, @attributes = data
    @key = @key.to_s
  end
  
  def title
    @key.to_s.humanize
  end
  
  def [](key)
    @attributes[key]
  end
  
end
