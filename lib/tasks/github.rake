namespace :github do
  desc "Fill database with github data"
  task populate_repositories: :environment do
    client = Octokit::Client.new(:access_token => APP_CONFIG["github_access_token"])
    client.org_repos("globaldev").each do |repo|
      Repository.find_or_create_by(name: repo.name)
    end
  end
end
