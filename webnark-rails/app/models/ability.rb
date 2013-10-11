class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

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
  end

  def user_perms(user)
    guest_perms

    can :manage, Service, :moderated => false, :user_id => user.id 
    can :add_comment, Service
    can :report, Service
    cannot :destroy, Service

    can :report, Comment
  end

  def guest_perms
    can :search, Service, :moderated => true
    can :full, Service, :moderated => true
    can :read, Service, :moderated => true
  end

end

