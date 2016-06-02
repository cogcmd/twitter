require 'cog/command'
require 'twitter'

class CogCmd::Twitter::Tweet < Cog::Command
  def run_command

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    tweet = client.update(request.args[0])
    response.template = "tweet"
    response.content = {"tweet_url" => tweet.url,
                        "tweet_text" => tweet.full_text}
  end
end
