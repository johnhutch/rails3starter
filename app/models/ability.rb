class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # load user signed in, or create new for guest

    @user.roles.each { |role| send role.name }

    if @user.roles.size == 0  # for guests without roles
      can :read, [Content, User, Post, Photo, Comment]
      can [:front], Content
    end
  end

  def nobody
    can :read, [Content, User, Post, Photo, Comment]
    can [:front], Content
  end

  def commenter
    can :create, Comment
    can [:update, :destroy], Comment, :user_id => @user.id
  end

  def author
    can :create, Post
    can [:update, :publish, :destroy], Post, :user_id => @user.id
  end

  def uploader
    can :create, Photo
    can [:update, :destroy], Photo, :user_id => @user.id
  end

  def admin
    can :manage, :all # the usual update/destroy, but for any model, not just those owned by user
    can [:create, :update, :destroy], Content
    can [:create, :update, :destroy], User
    can :manage, Role
  end

end
