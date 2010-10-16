class ProjectsController < ApplicationController
  before_filter :load_all_projects
  
  def index
    redirect_to project_path(Project.first.id)
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  private
  
    def load_all_projects
      @projects = Project.all
    end
end
