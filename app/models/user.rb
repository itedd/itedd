class User < ActiveRecord::Base
  include Authority::UserAbilities

  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :user_groups
end
