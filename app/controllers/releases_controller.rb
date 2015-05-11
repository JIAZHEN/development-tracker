class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  def new
    @repositories = Repository.all
  end

  def sync_github
    if authenticated?
      @repositories = Repository.all
    end
    respond_to do |format|
      format.json { render json: @repositories, status: 200 }
    end
  end
end
