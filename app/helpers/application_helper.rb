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
end
