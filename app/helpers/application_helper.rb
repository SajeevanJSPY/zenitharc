module ApplicationHelper
  def flash_type_to_daisyui(type)
    case type.to_sym
    when :notice then "alert-success"
    when :alert  then "alert-error"
    when :error  then "alert-error"
    when :info   then "alert-info"
    else "alert-info"
    end
  end

  def status_color(status)
    case status
    when "active" then "badge-success"
    when "suspended" then "badge-warning"
    when "closed" then "badge-error"
    else "badge-ghost"
    end
  end
end
