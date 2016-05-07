class Manage::CustomersController < ApplicationController
  layout 'users/user_layout'

  def index
    @customers = Customer.all
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
