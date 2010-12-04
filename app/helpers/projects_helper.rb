module ProjectsHelper
  def project_fail_count_class(project)
    if project.open_fails.count > 0
      'negative'
    else
      'positive'
    end
  end

  def showing_resolved?
    if params[:show_resolved] == "true"
      true
    else
      false
    end
  end
end
