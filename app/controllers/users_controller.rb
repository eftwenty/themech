class UsersController < ApplicationController
  layout 'user_layout'

  def index
    @title = 'Users'

    @users = User.all
  end

  def show
    @title = 'The title'
    @user = User.find(params[:id])
  end

  def new
    @title = 'Create the User'
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to(users_path, notice: t('notifications.users.successful_creation'))
    else
      render action: :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
