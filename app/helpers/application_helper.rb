module ApplicationHelper
  include Formats
  ALPHA_REGEX = '/^[A-z]+$/'

  ### View helpers
  def section_header label
    content_tag :h4 do
      content_tag(:strong, label) +
        content_tag(:hr)
    end
  end

  def get_vehicle_models(brand)
    begin
      "VehicleModels::#{brand.gsub(/[^A-z0-9]/, '_')}".constantize.sort
    rescue NameError
      []
    end
  end

  ### Active page
  def get_active_for path
    'active gradientable' if current_page?(path)
  end



  ### Current logged in person
  def current_logged_in
    current_user || current_customer
  end

  ### Unified Devise helpers
  def model_index_path
    send("#{underscored_resource}s_path")
  end

  def devise_session_path
    send("#{underscored_resource}_session_path")
  end

  def devise_registration_path
    send("#{underscored_resource}_registration_path")
  end

  def get_registration_path
    send("new_#{underscored_resource}_registration_path")
  end

  def devise_password_path
    send("#{underscored_resource}_password_path")
  end

  def get_devise_password_path
    send("new_#{underscored_resource}_password_path")
  end

  def devise_log_out_path
    send("destroy_#{underscored_resource}_session_path")
  end

  def underscored_resource
    current_logged_in.present? ? current_logged_in.class.to_s.underscore : resource.class.to_s.underscore
  end
end
