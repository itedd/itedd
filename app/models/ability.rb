class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :approve, User
    else
      can :read, :all
      can :manage, UserGroup, :user_id=>user.id
      UserGroup.where(user_id: user.id).each do |user_group|
        can :manage, Event, :user_group_id=>user_group.id
      end
    end
  end
end
