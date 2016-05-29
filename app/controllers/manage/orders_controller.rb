class Manage::OrdersController < ApplicationController
  layout 'users/user_layout'

  def index
    @orders = Order.all.order(:status)
  end
end