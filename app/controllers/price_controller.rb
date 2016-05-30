class PriceController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        ids = params[:service_ids]
        price = 0
        if ids.present?
          ids.each do |id|
            price += Service.find_by_id(id).price
          end
        end
        render json: {
            success: true,
            price: "#{price.to_f}"
        }
      end
    end
  end
end