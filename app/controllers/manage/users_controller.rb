class Manage::UsersController < ApplicationController
  layout 'users/user_layout'

  # before_action :authenticate!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to(users_path, notice: t('notifications.created', instance: 'user'))
    else
      render action: :new
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(user_params)
      redirect_to(users_path, notice: t('notifications.updated', instance: 'user'))
    else
      render action: :edit
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])

    if @user.destroy
      redirect_to(users_path, notice: t('notifications.deleted', instance: 'user'))
    else
      flash[:error] = 'Something went wrong'
      render action: :index
    end
  end

  private

  def user_params
    params.require(:user).permit(
        :first_name, :last_name, :email, role_list: [], work_variety_list: [],
        emails_attributes: [:id, :address, :_destroy],
        phones_attributes: [:id, :number, :primary, :_destroy]
    )
  end
end
