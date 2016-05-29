class MakeModelController < ApplicationController
  include OrdersHelper

  def index
    respond_to do |format|
      format.json do
        make = params[:make]
        models = get_vehicle_models(make)
        models_list = ""
        models.each do |model|
          models_list += "<option value=#{model}>#{model}</option>"
        end

        render json: {
            success: true,
            models: models_list
        }
      end
    end
  end
end