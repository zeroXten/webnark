class Ability
  include CanCan::Ability

  def initialize(user)

    unless user
      guest_perms
    else
       if user.admin?
         admin_perms(user)
       elsif user.moderator?
         moderator_perms(user)
       else
         user_perms(user)
       end
    end
  end

  def admin_perms(user)
    can :manage, :all
  end

  def moderator_perms(user)
    user_perms(user)

    can :manage, Comment
    can :manage, Service
  end

  def user_perms(user)
    guest_perms

    can :manage, Service, :moderated => false, :user_id => user.id 
    can :add_comment, Service
    can :report, Service
    can :tagged, Service
    cannot :destroy, Service

    can :report, Comment
    can :destroy, Comment, :user_id => user.id
  end

  def guest_perms
    can :search, Service, :moderated => true
    can :full, Service, :moderated => true
    can :read, Service, :moderated => true
  end

end

