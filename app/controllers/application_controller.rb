class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_all_projects
  
  def load_all_projects
    @projects = Project.all
  end
end
