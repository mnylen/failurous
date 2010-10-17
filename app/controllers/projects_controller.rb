class ProjectsController < ApplicationController
  before_filter :load_all_projects
  
  def index
    first_project = Project.first
    if first_project
      redirect_to project_path(Project.first.id)
    else
      redirect_to new_project_path
    end  
  end
  
  def new
    @project = Project.new
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:message] = "Saved"
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:message] = "Added"
      redirect_to project_path(@project, :created => true)
    else
      render 'new'
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
end
