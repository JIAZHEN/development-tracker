class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  def new
    @apps = App.all
  end

  def sync_github
    if authenticated?
      client.org_repos(ORGANISATION).each do |repo|
        App.find_or_create_by(name: repo[:name])
      end
    end
    redirect_to new_release_path
  end
end
