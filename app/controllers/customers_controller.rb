class CustomersController < ApplicationController
  layout 'customers/customer_layout'

  # before_action :authenticate_customer!

  def index
    @customers = Customer.all
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
