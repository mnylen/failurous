class ProjectsController < ApplicationController
  before_filter :load_all_projects
    
  def show
    @project = Project.first
  end
  
  private
  
    def load_all_projects
      @projects = Project.all
    end
end
