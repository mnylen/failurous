class Field
  
  attr_reader :key, :value
  
  def initialize(data)
    @key, @value, @attributes = data
    @key = @key.to_s
    @value = @value.inspect unless @value.kind_of?(String)
    @value = @value.gsub(/\\n/, "\n").gsub(/\\r/, "\r").gsub(/\\t/, "\t")
    @attributes = HashWithIndifferentAccess.new(@attributes)
  end
  
  def title
    if @attributes[:humanize_field_name].nil? or @attributes[:humanize_field_name]
      @key.to_s.humanize
    else
      @key.to_s
    end
  end
  
  def backtrace?
    @key.to_s =~ /back.*trace|stack/i
  end
  
  def [](key)
    @attributes[key]
  end
  
end

