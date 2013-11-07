class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :name, :email, :password, :password_confirmation

  validates :username, :email, :password, :password_confirmation, presence: true
  validates :password, confirmation: true, length: { minimum: 8 }
end
