module OrdersHelper

  def get_vehicle_models(make)
    begin
      "VehicleModels::#{make.gsub(/[^A-z0-9]/, '_')}".constantize.sort
    rescue NameError
      []
    end
  end

  def get_status_style o
    case o.status
      when 'Canceled'
        '-danger'
      when 'In progress'
        '-info'
      when 'Completed'
        '-success'
      else
        '-default'
    end
  end
end