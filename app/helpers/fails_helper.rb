module FailsHelper
  
  def fail_title(fail)
    truncate(fail.title, :length => 300)
  end
  
end
