class Manage::OrdersController < ApplicationController
  layout 'users/user_layout'

  def index
    @orders = params[:customer_id].present? ? Order.where(customer_id: params[:customer_id]) : Order.all
    @orders.order(:status)

    @orders
  end
end