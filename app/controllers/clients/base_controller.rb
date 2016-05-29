class Clients::BaseController < ApplicationController
  layout 'customers/customer_layout'

  before_action :check_current_customer
  before_filter :get_current_customer

  private

  def get_current_customer
    @customer = current_customer
  end

  def check_current_customer
    unless current_customer
      redirect_to new_customer_session_path, notice: t('devise.failure.unauthenticated')
    end
  end
end