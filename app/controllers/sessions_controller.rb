class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      login_user!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Username/Password combination not found"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
