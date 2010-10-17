module Failurous
  class Config
    @@server_address = ""
    @@api_key = ""
    
    class << self
      def server_address=(val)
        @@server_address = val
      end
    
      def server_address
        @@server_address
      end
    
      def api_key=(val)
        @@api_key = val
      end
    
      def api_key
        @@api_key
      end
    end
  end
end