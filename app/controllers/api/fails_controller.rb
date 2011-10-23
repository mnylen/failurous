class Api::FailsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def create
    project = Project.by_api_key(params[:api_key])
    if !project
      render :status => :unauthorized, :text => "Invalid API key provided\r\n"
      return
    end

    fail_data = JSON.parse(params[:data]) rescue nil
    if fail_data.nil? or !fail_data.is_a?(Hash) 
      render :status => :bad_request, :text => "Invalid or missing fail data\r\n"
      return
    end

    begin
      Fail.create_or_combine(project, fail_data)
      render :status => :created, :text => "Fail created\r\n"
    rescue
      Rails.logger.warn($!, $!.backtrace)
      render :status => :bad_request, :text => "Invalid or missing fail data\r\n"
    end
  end
end
