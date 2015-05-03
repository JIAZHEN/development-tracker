module GithubHelper

  def scopes
    "user:email,repo".freeze
  end

  def client
    @client ||= if authenticated?
      Octokit::Client.new(access_token: session[:access_token])
    else
      Octokit::Client.new(client_id: APP_CONFIG["github_client_id"],
        client_secret: APP_CONFIG["github_client_secret"])
    end
  end

  def authorize_url
    client.authorize_url(APP_CONFIG["github_client_id"], scope: scopes)
  end

  def exchange_token(code)
    result = Octokit.exchange_code_for_token(code, APP_CONFIG["github_client_id"], APP_CONFIG["github_client_secret"])
    result[:access_token]
  end

  def authenticated?
    session[:access_token]
  end

  def authenticate!(access_token)
    session[:access_token] = access_token
    @client = Octokit::Client.new(access_token: access_token)
  end

end
