module ApplicationHelper
  def twitter_link(user_group)
    account = user_group.twitter_account
    if account
      if account[0]=='@'
        return "https://twitter.com/#{user_group.twitter_account[1..-1]}"
      else
        return "https://twitter.com/#{user_group.twitter_account}"
      end
    end
  end

  def user_link(user)
    if current_user!=user && can?(:manage, user)
      link_to user.email, edit_user_admin_path(user)
    else
      mail_to user.email
    end
  end

  def user_group_link(user_group)
    if user_group.present?
      link_to user_group.name, user_group_path(user_group)
    end
  end
end
