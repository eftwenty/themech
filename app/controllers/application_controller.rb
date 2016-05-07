class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate!
  #
  # private
  #
  def authenticate!
    if params[:controller].include?('manage')
      if (!current_user && !current_customer) || current_user
        authenticate_user!
      else
        reset_session
      end
    elsif params[:controller].include?('clients')
      authenticate_customer!
    else
      return
    end
  end
end
