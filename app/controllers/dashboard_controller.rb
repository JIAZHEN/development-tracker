class DashboardController < ApplicationController
  def index
  end

  def login
    redirect_to(authenticated? ? root_path : authorize_url)
  end

  def authenticate
    unless authenticated?
      access_token = exchange_token(params[:code])
      session[:access_token] = access_token
    end
    redirect_to root_path
  end
end
