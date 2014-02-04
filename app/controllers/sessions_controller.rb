class SessionsController < ApplicationController
	def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    redirect_to root_url, :notice => "Logged in!"
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
  	render 'new'
  end
  end
  def destroy
  	cookies.delete(:auth_token)
  redirect_to root_url, :notice => "Logged out!"
  end
 end
