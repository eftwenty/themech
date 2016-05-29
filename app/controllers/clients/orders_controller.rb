class Clients::OrdersController < Clients::BaseController

  def show
    @order = Order.find_by_id(params[:id])
  end

  def new
    @order = Order.new customer_id: @customer.id
  end

  def create
    ### TODO: Tut pizdec, potom pofikshu
    @order = Order.new order_params.deep_merge!(customer_id: @customer.id)

    if services_params && services_params.map {|k, v| v[:id]}.reject {|id| id.blank?}.present?
      service_ids = services_params.map {|k, v| v[:id]}
      service_ids.each do |service_id|
        @order.services << Service.find_by_id(service_id)
      end
    end

    if @order.save
      redirect_to(available_services_path, notice: t('notifications.customers.created_order'))
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
        :customer_id, :make, :model
    # ,
    #     services_attributes: [:id, :_destroy]
    )
  end

  def services_params
    params[:order][:services_attributes]
  end
end