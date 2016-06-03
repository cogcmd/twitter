require 'cog/command'
require 'twitter'

class CogCmd::Twitter::Tweet < Cog::Command

  def run_command
    client = Twitter::REST::Client.new(user_credentials!(request))

    begin
      tweet = client.update(request.args.join(" "))

      response.template = "tweet"
      response.content  = {"tweet_url"    => tweet.url,
                           "tweet_text"   => tweet.full_text,
                           "account_name" => tweet.user.screen_name}
    rescue Twitter::Error::Unauthorized
      fail("Could not authenticate; check your credentials.")
    end
  end

  # Generate a map of Twitter client credentials from environment
  # variables supplied in the request, or fail if any required
  # variable is not present.
  def user_credentials!(request)
    user = request.options["as"] ||
           env_var("TWITTER_DEFAULT_ACCOUNT",
                   failure_message: "No --as option given, and no TWITTER_DEFAULT_ACCOUNT specified")

    user = user.upcase

    {consumer_key: env_var("TWITTER_CONSUMER_KEY", suffix: user),
     consumer_secret: env_var("TWITTER_CONSUMER_SECRET", suffix: user),
     access_token: env_var("TWITTER_ACCESS_TOKEN", suffix: user),
     access_token_secret: env_var("TWITTER_ACCESS_TOKEN_SECRET", suffix: user)}
  end


end
