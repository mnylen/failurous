module ProjectsHelper
  def negative_or_positive_count(project)
    if project.open_fails.count > 0
      'negative'
    else
      'positive'
    end
  end

  def toggler_class(state)
    if params[:show_resolved]
      case state
        when :off then 'enabled'
        when :on then 'disabled'
      end
    else
      case state
        when :off then 'disabled'
        when :on then 'enabled'
      end
    end
  end

end
