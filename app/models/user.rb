class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  belongs_to :user_group

  accepts_nested_attributes_for :user_group

  default_scope { order('email ASC') }
  scope :admins, -> { where('admin=true') }

  after_create :send_mail_to_admin

  def self.new_with_session(hash, session)
    hash.delete 'user_group_attributes' if hash['user_group_id'].present?
    user = super
    user.user_group = UserGroup.new if user.user_group.nil?
    user
  end

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

  def send_mail_to_admin
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end
end
