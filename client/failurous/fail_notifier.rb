require 'net/http'
require 'uri'

module Failurous
  class FailNotifier
    def self.send_fail(notification)
      server_address, api_key = [Failurous::Config.server_address, Failurous::Config.api_key]
      post_address = "#{server_address}/api/projects/#{api_key}/fails"
      
      p Net::HTTP.post_form URI.parse(post_address), {:data => notification.to_json}
    end
  end
end