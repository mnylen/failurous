module FailsHelper
  
  def fail_title(fail)
    truncate(fail.title, :length => 300)
  end

  def fail_css_class(fail)
    css_class = "collapsed "
    if fail.resolved
      css_class << "resolved"
    end

    css_class
  end
end
