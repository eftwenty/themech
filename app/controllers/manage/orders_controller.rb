class Manage::OrdersController < ApplicationController
  layout 'users/user_layout'

  def index
    @orders = params[:customer_id].present? ? Order.where(customer_id: params[:customer_id]) : Order.all
    @orders.order(:status)

    if params[:customer_id]
      @customer = Customer.find_by_id(params[:customer_id])
    end
  end

  def show
    @order = Order.find_by_id(params[:id])
    @customer = @order.customer
  end
end