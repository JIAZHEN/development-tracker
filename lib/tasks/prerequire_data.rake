namespace :db do
  desc "Fill database with initial data"
  task populate: :environment do
    %w{ qa1 qa2 qa3 qa4 qa5 staging1 staging2 production }.each do |env|
      Environment.find_or_create_by(name: env)
    end

    ["wait to deploy", "deploying", "deployed", "rolling back", "rolled back"].each do |env|
      Status.find_or_create_by(name: env)
    end

    # popular repositories
    client = Octokit::Client.new(
      :access_token => APP_CONFIG["github_access_token"],
      :auto_paginate => true)

    client.org_repos("globaldev").each do |repo|
      Repository.find_or_create_by(name: repo.name)
    end
  end
end
