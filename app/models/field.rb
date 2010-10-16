class Field
  
  attr_reader :key, :value
  
  def initialize(data)
    @key, @value, @attributes = data
  end
  
  def title
    @key.to_s.humanize
  end
  
  def [](key)
    @attributes[key]
  end
  
end
