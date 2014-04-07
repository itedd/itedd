class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :user_groups

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super
    end
  end
end
