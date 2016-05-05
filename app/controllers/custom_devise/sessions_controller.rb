class CustomDevise::SessionsController < Devise::SessionsController
  layout 'custom_devise/layout'

  before_filter :prevent_customers, except: [:destroy]

  def prevent_customers
    if current_customer
      flash[:alert] = t('devise.failure.already_authenticated')
      redirect_to customers_path
    end
  end
end