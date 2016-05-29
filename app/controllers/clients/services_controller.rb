class Clients::ServicesController < Clients::BaseController
  def index
    @services = Service.available
  end
end