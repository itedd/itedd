class TwitterReader
  def self.twitter_accounts
    User.with_twitter
  end
end
