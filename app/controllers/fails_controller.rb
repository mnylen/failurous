class FailsController < ApplicationController  
  before_filter :load_fail
  
  def show
  end
  
  def resolve
    @fail.resolve!
    flash[:message] = "Resolved"
    redirect_to params[:return_to] || project_path(@fail.project) 
  end

  private
  
  def load_fail
    @fail = Fail.find(params[:id])
    @project = @fail.project
  end
  
end

