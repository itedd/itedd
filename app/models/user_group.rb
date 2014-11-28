class UserGroup < ActiveRecord::Base
  include Ensures

  validates :name, presence: true, length: {minimum: 4, maximum: 100}
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
  scope :with_twitter, -> { where('twitter_account is not null and twitter_account != ?', '') }
  scope :with_ical, -> { where('ical_url is not null and ical_url != ?', '') }

  ensure_link :website

  def approved?
    users.select do |user|
      user.approved==true
    end.size>0
  end
end
