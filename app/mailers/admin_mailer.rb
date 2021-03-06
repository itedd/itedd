class AdminMailer < ActionMailer::Base
  default from: ENV['EMAIL_SENDER'] || 'noreply@localhost.org'

  def new_user_waiting_for_approval(user)
    @user = user
    User.admins.each do |admin|
      mail(to: admin.email, subject: '[ITEDD] Ein neuer Benutzer wartet auf Freigabe')
    end
  end
end
