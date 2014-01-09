class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  #attr_accessible :name, :email, :password, :password_confirmation


  validates :username, presence: true, length: {minimum: 10, maximum: 100}
end
