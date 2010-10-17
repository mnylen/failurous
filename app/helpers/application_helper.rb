
module ApplicationHelper

  SLOGANS = [
    "Fails you while you sleep",
    "Watching your fail 24/7",
    "Tracking teh fail since 2010",
    "I'm in ur app, watching it fail",
    "Putting the urous in fail since 2010",
    "Boldly going where no fail has gone before"
  ]
    
  def selected_project_path
    if @project and !(@project.new_record?)
      project_path(@project)
    else
      ''
    end
  end
  
  def projects_choices(projects)
    [].tap do |choices|
      choices << ['', root_path]
      projects.each do |project|
        choices << [project.name, project_path(project)]
      end
    end
  end
  
  def slogan
    SLOGANS.sort_by { rand }.first
  end
  
end
