class Clients::ServicesController < ApplicationController
  layout 'customers/customer_layout'

  def index
    @services = Service.available
  end
end