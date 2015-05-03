module GithubHelper

  def scopes
    "user:email,repo".freeze
  end

  def github
    @github ||= Github.new(client_id: APP_CONFIG["github_client_id"],
      client_secret: APP_CONFIG["github_client_secret"])
  end

  def authorize_url
    github.authorize_url(scope: scopes)
  end

  def exchange_token(code)
    github.get_token(code)
  end

  def authenticated?
    session[:access_token]
  end

end
