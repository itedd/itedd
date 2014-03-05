class User < ActiveRecord::Base
  include Authority::UserAbilities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  #attr_accessible :name, :email, :password, :password_confirmation


  validates :username, presence: true, length: {minimum: 4, maximum: 100}
end
