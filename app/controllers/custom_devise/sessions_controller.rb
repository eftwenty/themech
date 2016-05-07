class CustomDevise::SessionsController < Devise::SessionsController
  layout 'custom_devise/layout'

  before_filter :move_forward, only: [:create]

  def get_home
    home = if current_customer
             client_path(current_customer)
           elsif current_user
             customers_path
           else
             root_path
           end
  end

  def move_forward
    return if !current_customer && !current_user
    redirect_to get_home
  end
end