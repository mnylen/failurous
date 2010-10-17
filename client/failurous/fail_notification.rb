require 'active_support'

module Failurous
  class FailNotification
    attr_accessor :title
    attr_accessor :data
  
    # Builds a Notification from the given exception:
    #
    # Title: #{type}: #{message}
  
    # Summary
    #   - type
    #   - message (not used when combining)
    #   - topmost line in backtrace
    # 
    # Details:
    #   - full backtrace
    #
    def from_exception(exception)
      self.set_title("#{exception.class}: #{exception.message}").
        add_field(:summary, :type, exception.class.to_s, {:use_in_checksum => true}).
        add_field(:summary, :message, exception.message, {:use_in_checksum => false}).
        add_field(:summary, :topmost_line_in_backtrace, exception.backtrace[0], {:use_in_checksum => true}).
        add_field(:details, :full_backtrace, exception.backtrace.join('\n'), {:use_in_checksum => false})
    end
  
    def set_title(title)
      @title = title
      self
    end
  
    def add_field(section_name, field_name, field_value, field_options = {})
      @data ||= []
    
      found = false
      field   = [field_name, field_value, field_options]
    
      data.each do |existing_section|
        if existing_section[0] == section_name
          existing_section[1] << field
          found = true
          break
        end
      end
    
      unless found
        data << [section_name, [field]]
      end
    
      self
    end
  
    def to_json
      ActiveSupport::JSON.encode({:title => @title, :data => @data})
    end
    
    def send
      FailNotifier.send_fail(self)
    end
  end
end