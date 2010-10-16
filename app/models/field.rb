class Field
  
  attr_reader :key, :value
  
  def initialize(data)
    @key, @value, @attributes = data
    @key = @key.to_s
    @value = @value.gsub(/\\n/, "\n").gsub(/\\r/, "\r").gsub(/\\t/, "\t")
  end
  
  def title
    @key.to_s.humanize
  end
  
  def backtrace?
    @key.to_s =~ /back.*trace|stack/i
  end
  
  def [](key)
    @attributes[key]
  end
  
end

