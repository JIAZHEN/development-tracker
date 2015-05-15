class DashboardController < ApplicationController
  skip_before_action :require_authentication

  def index
    if authenticated?
      @counters = {}
      @counters[:new] = Release.where(status_id: Status::WAIT_TO_DEPLOY).count
      @counters[:deploying] = Release.where(status_id: Status::DEPLOYING).count
      @counters[:deployed] = Release.where(status_id: Status::DEPLOYED).count
      @counters[:rolled_back] = Release.where(status_id: Status::ROLLED_BACK).count

      @lastest_releases = Release.order(:id => :desc).last(10)
    end
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
