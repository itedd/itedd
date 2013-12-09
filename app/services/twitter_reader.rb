class TwitterReader
  class << self
    def twitter_accounts
      User.with_twitter
    end

    def cronjob
      twitter_accounts.each do |account|
        new(account).run
      end
    end

    def client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end
    end
  end

  def initialize(user)
    @user = user
    @twitter_account = user.twitter_account
  end

  def run
    tweets.each do |tweet|
      if tweet.text.include? '#event'
        EventFactory.new.createEvent( tweet.text, @user )
      end
    end
  end


  private

  def tweets
    self.class.client.user_timeline(@twitter_account,
                                    exclude_replies: true,
                                    trim_user: true,
                                    include_rts: false)
  end



end
