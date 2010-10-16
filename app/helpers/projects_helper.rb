module ProjectsHelper
  def project_css_class(project)
    css_class = "project "
    css_class << "selected-project" if @project == project
    css_class
  end
end