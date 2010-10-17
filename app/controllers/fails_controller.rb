class FailsController < ApplicationController
  
  before_filter :load_fail
  
  def show
  end
  
  def ack
    @fail.ack!
    flash[:message] = "Acknowledged"
    redirect_to project_url(@project)
  end

  private
  
  def load_fail
    @fail = Fail.find(params[:id])
    @project = @fail.project
  end
  
end

