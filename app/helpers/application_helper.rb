module ApplicationHelper
  def selected_project_path
    if @project
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
end
