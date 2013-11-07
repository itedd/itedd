class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :name, :email, :password, :password_confirmation

  validates :username, presence: true, length: {minimum: 10, maximum: 100}

  #validates :color, presence: true
  #
  #validates :logo, length: {maximum: 200}
  #validates :website, length: {maximum: 200}
  #validates :description, length: {maximum: 400}   # html is allowed
  #validates :twitter_name, length: {maximum: 200}
  #validates :facebook_page, length: {maximum: 200}
  #validates :google_plus_page, length: {maximum: 200}
end
