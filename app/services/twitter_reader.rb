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
    events = []
    begin
      Rails.logger.info "Loading tweets for #{@user_group.name}"
      unless @user_group.logo.present?
        @user_group.logo = profile_image_url
        @user_group.save
      end
      events = extract_events
      Rails.logger.info " #{events.size} relevant tweets found"
      store_events(events)
    rescue Exception => e
      Rails.logger.warn e
    end
    events
  end

  private

  def extract_events
    tweets.collect do |tweet|
      event = build_event( tweet[:text], @user_group, tweet[:url] )
      if event
        event.link = tweet[:url]
        event.twitter_id = tweet[:id].to_s
      end
      event
    end.compact
  end

  def store_events(events)
    events.each do |event|
      if Event.with_deleted.where( twitter_id: event.twitter_id).count == 0
        existing_event = Event.with_deleted.where( link: event.link ).first
        if existing_event
          existing_event.happens_at = event.happens_at
          existing_event.text = event.text
          existing_event.save
        else
          event.save
        end
      end
    end
  end

  def profile_image_url
    self.class.client.user(@twitter_account).profile_image_url.to_s
  end

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
