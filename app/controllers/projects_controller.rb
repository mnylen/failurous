class ProjectsController < ApplicationController
  
  def show
    @project = Project.first
  end

end
