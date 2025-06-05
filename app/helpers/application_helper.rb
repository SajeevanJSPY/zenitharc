module ApplicationHelper
  def flash_type_to_daisyui(type)
    case type.to_sym
    when :notice then "alert-info"
    when :alert  then "alert-warning"
    when :error  then "alert-error"
    else "alert-info"
    end
  end
end
