class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  def new
    @repositories = Repository.all
    @release = Release.new
  end

  def get_branches
    repository = Repository.find_by(name: params["repository"])
    branches = if params["type"] == "sync"
      sync_branches_from_github(repository)
    else
      repository.active_branches
    end
    respond_with_json branches
  end

  def create
  end

  private

  def respond_with_json(data)
    respond_to do |format|
      format.json { render json: data, status: 200 }
    end
  end

  def sync_branches_from_github(repository)
    client.branches("#{ORGANISATION}/#{repository.name}").map do |branch|
      repository.branches.find_or_create_by(name: branch.name)
    end
  end
end
