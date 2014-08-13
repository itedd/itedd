module UserGroupAdminsHelper
  def organizer_for_group(user_group)
    user_group.users.collect do |user|
      user_link(user)
    end.join(', ').html_safe
  end
end
