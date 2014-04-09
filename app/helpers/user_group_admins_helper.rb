module UserGroupAdminsHelper
  def organizer_for_group(user_group)
    user_group.users.collect do |user|
      user.email
    end.join(', ')
  end
end
