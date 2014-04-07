class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :approve, User
    else
      can :read, :all
      ug = user.user_group
      if ug.present?
        can :manage, UserGroup, :id=>ug.id
        can :manage, Event, :user_group_id=>ug.id
      end
    end
  end
end
