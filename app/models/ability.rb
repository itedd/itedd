class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
<      can :manage, :all
      cannot :manage, User, id: user.id
    else
      can :read, :all
      user_group = user.user_group
      if user_group.present?
        can :manage, UserGroup, id: user_group.id
        can :manage, Event, user_group_id: user_group.id
      end
    end
  end
end
