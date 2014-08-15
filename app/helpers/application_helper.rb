module ApplicationHelper
  def nav_link(link_text, link_path, opts={})
    class_name = current_page?(link_path) ? 'active' : ''
    content_tag(:li, :class=>class_name) do
      link_to link_text, link_path, opts
    end
  end

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

  def is_mobile_device?
    !!(request.user_agent =~ /mobile/i)
  end
end
