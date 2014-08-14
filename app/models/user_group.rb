class UserGroup < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :color, presence: true, format: { with: %r{\A(#[0-9A-Fa-f]{6})\z}}
  validates :logo, length: {maximum: 200}
  validates :website, length: {maximum: 200}
  validates :description, length: {maximum: 400}   # html is allowed
  validates :facebook_page, length: {maximum: 200}
  validates :googleplus_page, length: {maximum: 200}
  validates :twitter_account, length: {maximum: 200},
            format: { with: %r{\A(\@\w+|)\z} }, if: ->(r) { r.twitter_account.present? }

  has_many :events, -> { newest_first }, foreign_key: :user_group_id
  has_many :users

  default_scope { ordered }

  scope :approved, -> { joins(:users).where(users:{approved:true}).uniq }
  scope :ordered, -> { order('name ASC') }
  scope :with_twitter, -> { where('twitter_account is not null') }

  before_update :check_website_link

  def approved?
    users.select do |user|
      user.approved==true
    end.size>0
  end

  def check_website_link
    if website && !website.start_with?('http://') && !website.start_with?('https://')
      self.website = "http://#{website}"
    end
  end
end
