class Manage::OrdersWorkflowController < ApplicationController
  before_filter :get_order

  def accept
    @order.status = 'In progress'

    result = @order.workers_autoselect

    if result[:workers].present?
      workers_names = result[:workers].map{|w| w.decorate.pretty_name}.join(', ')
      @order.users = result[:workers]
      @order.users.update_all(status: 'Busy')
    end

    cant_be_done = result[:cant_be_completed].join(', ') if result[:cant_be_completed].present?

    message = "The order has been accepted successfully."
    message += " <strong>#{ApplicationController.helpers.pluralize(result[:workers].count, 'worker')}</strong> assigned (#{workers_names})." if result[:workers].present?
    message += " <strong>#{cant_be_done}</strong> works can't be completed because of lack of free/qualified workers" if result[:cant_be_completed].present?

    if @order.users.present? && @order.save
      redirect_to(order_path(@order), notice: message)
    else
      redirect_to(order_path(@order), flash: {alert: "Can't be accepted because of lack of free/qualified workers"} )
    end
  end

  def cancel
    @order.status = 'Canceled'
    if @order.users.present?
      @order.release_workers
      @order.users = []
    end

    if @order.save
      redirect_to(order_path(@order), flash: {success: 'The order has been canceled. All workers unassigned.'} )
    else
      redirect_to(order_path(@order), flash: {warning: 'Something went wrong.'} )
    end
  end

  def complete
    @order.status = 'Completed'

    @order.release_workers

    if @order.save
      redirect_to(order_path(@order), flash: {notice: 'The order is completed..'} )
    else
      redirect_to(order_path(@order), flash: {warning: 'Something went wrong.'} )
    end
  end

  def make_pending
    @order.status = 'Pending'

    if @order.users.present?
      @order.release_workers
      @order.users = []
    end

    if @order.save
      redirect_to(order_path(@order), flash: {notice: 'The order is pending and could be pushed thru workflow.'} )
    else
      redirect_to(order_path(@order), flash: {warning: 'Something went wrong.'} )
    end
  end

  private

  def get_order
    @order = Order.find_by_id(params[:order_id])
  end
end