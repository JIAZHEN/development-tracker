class DashboardController < ApplicationController
  def index
    @github_client_id = APP_CONFIG["github_client_id"]
    @github_client_secret = APP_CONFIG["github_client_secret"]
  end
end
