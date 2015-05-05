class DashboardController < ApplicationController
  def index
  end

  def login
    redirect_to(authenticated? ? root_path : authorize_url)
  end

  def callback
    unless authenticated?
      access_token = exchange_token(params[:code])
      if access_token.blank?
        flash[:danger] = "Invalid callback code. " +
          "Please check the application registeration and permission."
      else
        session[:access_token] = access_token
      end
    end
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
