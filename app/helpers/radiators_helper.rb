module RadiatorsHelper
  
  def ok_project_colspan
    case @ok_projects.size
    when 1..2 then 1
    when 3..4 then 2
    else 3
    end
  end
  
  def ok_project_size
    case ok_project_colspan
    when 1 then "large"
    when 2 then "med"
    else "small"
    end
  end
  
end
