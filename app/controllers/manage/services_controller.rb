class Manage::ServicesController < ApplicationController
  layout 'users/user_layout'

  def index
    @services = Service.all
  end

  def show
    @service = Service.find_by_id(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new service_params

    if @service.save
      redirect_to(services_path, notice: t('notifications.created', instance: 'service'))
    else
      render action: :new
    end
  end

  def edit
    @service = Service.find_by_id(params[:id])
  end

  def update
    @service = Service.find_by_id(params[:id])

    if @service.update(service_params)
      redirect_to(services_path, notice: t('notifications.updated', instance: 'service'))
    else
      render action: :edit
    end
  end

  def destroy
    @service = Service.find_by_id(params[:id])

    if @service.destroy
      redirect_to(services_path, notice: t('notifications.deleted', instance: 'service'))
    else
      flash[:error] = 'Something went wrong'
      render action: :index
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :man_hours, variety_list: [])
  end
end