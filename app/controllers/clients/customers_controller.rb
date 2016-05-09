class Clients::CustomersController < ApplicationController
  layout 'customers/customer_layout'

  before_action :check_current_customer
  before_filter :get_current_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(update_params)
      redirect_to(client_path(@customer), flash: { success: t('notifications.customers.updated') })
    else
      render action: :edit
    end
  end

  private

  def update_params
    params.require(:customer).permit(
        :first_name, :last_name, :email,
        emails_attributes: [:id, :address, :_destroy],
        phones_attributes: [:id, :number, :primary, :_destroy]
    )
  end

  def get_current_customer
    @customer = current_customer
  end

  def check_current_customer
    unless current_customer
      redirect_to new_customer_session_path, notice: t('devise.failure.unauthenticated')
    end
  end
end