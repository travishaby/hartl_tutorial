class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: email)
    if @user && @user.authenticate(params[:user][:password])
      log_in @user
      params[:user][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to user_path @user
    else
      flash.now[:error] = "Sorry, invalid login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end

  private

    def session_params
      params.require[:user].permit(:email, :password)
    end

    def email
      params[:user][:email] if params[:user]
    end
end
