class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :user_groups
end
