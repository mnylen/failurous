module ProjectsHelper

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
