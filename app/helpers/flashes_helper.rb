module FlashesHelper
  def user_facing_flashes
    flash.to_hash.slice("alert", "error", "notice", "success")
  end

  def flash_class(flash_type)
    case flash_type
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-error"
      when 'alert' then "alert alert-error"
    end
  end
end
