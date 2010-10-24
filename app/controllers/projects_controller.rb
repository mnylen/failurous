class ProjectsController < ApplicationController
  before_filter :load_all_projects
  
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
    load_fails
  end


  private

    def load_fails
      @fails = if params[:show_resolved] == "true"
        @project.fails
      else
        @project.open_fails
      end
    end
end
