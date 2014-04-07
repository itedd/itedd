class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  belongs_to :user_group

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
