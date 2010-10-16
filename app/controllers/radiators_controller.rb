class RadiatorsController < ApplicationController
  
  layout "radiator"
  
  def show
    projects = Project.all
    @failed_projects = projects.select { |p| p.has_open_fails? }
    @ok_projects = projects.reject { |p| p.has_open_fails? }    
  end
  
end
