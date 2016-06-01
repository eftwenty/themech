class Clients::CustomersController < Clients::BaseController

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
        :first_name, :last_name, :email, :gender,
        emails_attributes: [:id, :address, :_destroy],
        phones_attributes: [:id, :number, :primary, :_destroy]
    )
  end
end