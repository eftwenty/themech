class Manage::ServicesController < ApplicationController
  layout 'users/user_layout'

  def index
    @services = Service.order(pending: :desc)
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

    old_variety_list = @service.variety_list
    old_service_attibutes = @service.attributes
    @service.assign_attributes service_params
    if @service.save && old_variety_list != @service.variety_list && old_service_attibutes != @service.attributes
      ServiceMailer.user_changed_service(current_user, @service).deliver
      redirect_to(services_path, notice: t('notifications.updated', instance: 'service'))
    elsif @service.save
      redirect_to services_path
    else
      render action: :edit
    end
  end

  def destroy
    @service = Service.find_by_id(params[:id])

    if @service.destroy
      ServiceMailer.deleted_service(current_user, @service).deliver
      redirect_to(services_path, notice: t('notifications.deleted', instance: 'service'))
    else
      flash[:error] = 'Something went wrong'
      render action: :index
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :man_hours, :price, :pending, variety_list: [])
  end
end