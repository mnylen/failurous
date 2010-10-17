class HomeController < ApplicationController
  
  def index
    unless cookies[:shatner]
      @shatner = true
      cookies[:shatner] = { :value => "tech wars", :expires => 1.year.from_now }
    end
  end
  
end
