class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    can :read, User
    if user.blank?
      
    else
      can :manage, User, id: user.id
      if user.has_role? :performer
        can :manage, Song, user_id: user.id
        can :manage, Video, user_id: user.id
        can :manage, Post, user_id: user.id
        can :manage, Gig, performer_id: user.id
        can :manage, Message, gig: {performer_id: user.id}
      elsif user.has_role? :booker
        can :manage, Gig, booker_id: user.id
        can :manage, Message, gig: {booker_id: user.id}
        can :manage, Review, gig: {booker_id: user.id}
      end
      
      if user.has_role? :admin
        can :manage, User
        can :manage, Song
        can :manage, Video
        can :manage, Post
        can :manage, Gig
        can :manage, Message
      end
    end
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
  end
end
