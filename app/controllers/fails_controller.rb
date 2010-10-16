class FailsController < ApplicationController
  
  before_filter :load_fail
  
  def show
  end
  
  def ack
    @fail.ack!
    redirect_to project_url(@fail.project)
  end

  private
  
  def load_fail
    @fail = Fail.find(params[:id])
  end
  
end

