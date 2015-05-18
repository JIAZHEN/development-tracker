module ReleasesHelper

  SLACK_TOKEN = APP_CONFIG["slack_token"]

  def slack_post
    uri = URI.parse("https://slack.com/api/chat.postMessage")
    Net::HTTP.post_form(uri, {
      "token" => SLACK_TOKEN,
      "channel" => "@jxie",
      "text" => "submitted by @jxie",
      "parse" => "full"
    })
  end
end
