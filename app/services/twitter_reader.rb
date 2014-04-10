class TwitterReader < BaseReader
  class << self
    def twitter_accounts
      UserGroup.with_twitter
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

  def initialize(user_group)
    @user_group = user_group
    @twitter_account = user_group.twitter_account
  end

  def run
    begin
      Rails.logger.info "Loading tweets for #{@user_group.name}"
      tweets.each do |tweet|
        event = build_event( tweet[:text], @user_group, tweet[:url] )
        if event
          if Event.where( twitter_id: tweet[:id].to_s).count > 0
            next
          end
          event.link = tweet[:url]
          event.twitter_id = tweet[:id].to_s
          event.save
        end
      end
    rescue Exception => e
      Rails.logger.warn e
    end
  end

  private

  def tweets
    self.class.client.user_timeline(@twitter_account,
                                    exclude_replies: true,
                                    trim_user: true,
                                    include_rts: false).map do |tweet|
                                      {
                                        id: tweet.id,
                                        text: tweet.text,
                                        url: tweet.urls.last.try(:url).try(:to_s)
                                      }
                                    end
  end



end
