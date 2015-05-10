class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  def new
    @repositories = Repository.all
  end

  def sync_github
    if authenticated?
      client.org_repos(ORGANISATION).each do |repo|
        repository = Repository.find_or_create_by(name: repo.name)
        client.branches(repo.full_name).each do |branch|
          repository.branches.find_or_create_by(name: branch.name)
        end
      end
    end
    redirect_to new_release_path
  end
end
