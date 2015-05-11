class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  def new
    @repositories = Repository.all
  end

  def sync_github
    if authenticated?
      repository = Repository.find(params["repository_id"].to_i)
      @branches = client.branches("#{ORGANISATION}/#{repository.name}").map do |branch|
        repository.branches.find_or_create_by(name: branch.name)
      end
    end
    respond_to do |format|
      format.json { render json: @branches, status: 200 }
    end
  end

  private

  def update_branches

  end
end
