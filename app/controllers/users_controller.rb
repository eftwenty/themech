class UsersController < ApplicationController
  layout 'user_layout'

  def index
    @title = 'Users'
  end

  def new
    @user = User.new params[:user_params]
  end

  private

  def user_params
    params.require(:user).permit(
        :first_name,
        :last_name
    )
  end
end
