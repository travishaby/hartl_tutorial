class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: email)
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = User.find_by(email: email).id
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Sorry, invalid login"
      render :new
    end
  end

  private

    def session_params
      params.require[:user].permit(:email, :password)
    end

    def email
      params[:user][:email] if params[:user]
    end
end
