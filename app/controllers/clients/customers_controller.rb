class Clients::CustomersController < ApplicationController
  layout 'customers/customer_layout'

  before_action :check_current_customer

  def index
  end

  def show
    @customer = current_customer
  end

  private

  def check_current_customer
    unless current_customer
      redirect_to new_customer_session_path, notice: t('devise.failure.unauthenticated')
    end
  end
end