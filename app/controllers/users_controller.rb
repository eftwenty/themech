class UsersController < ApplicationController
  layout 'user_layout'

  def index
    @users = User.all
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
      redirect_to(users_path, notice: t('notifications.users.created'))
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
      redirect_to(users_path, notice: t('notifications.users.updated'))
    else
      render action: :edit
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])

    if @user.destroy
      redirect_to(users_path, notice: t('notifications.users.deleted'))
    else
      flash[:error] = 'Something went wrong'
      render action: :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, emails_attributes: [:id, :address, :primary, :_destroy])
  end
end
