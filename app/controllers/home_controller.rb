class HomeController < ApplicationController
  
  def index
    project = Project.first

    unless project
      redirect_to new_project_path
    else
      redirect_to project_path(project)
    end
  end

  def random_slogan
    render :layout => false
  end
  
end
