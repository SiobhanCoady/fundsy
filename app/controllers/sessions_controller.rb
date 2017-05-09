class SessionsController < ApplicationController
  def new
  end

  def create
    # find the user by their email
    # if the email is found, authenticate the password
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Thank you for signing in'
    else
      flash.now[:alert] = 'Wrong credentials!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed Out'
  end
end
