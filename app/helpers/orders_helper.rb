module OrdersHelper

  def get_vehicle_models(make)
    begin
      "VehicleModels::#{make.gsub(/[^A-z0-9]/, '_')}".constantize.sort
    rescue NameError
      []
    end
  end
end