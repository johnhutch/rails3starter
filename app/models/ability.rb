class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user if not logged in
    
    if user.role?       :admin
      can :manage, :all
    elsif user.role?    :editor
      can :read, :all
    elsif user.role?    :commenter
      can :read, :all
    elsif user.role?    :sponsor
      can :read, :all
    elsif user.role?    :hopeful
      can :read, :all
    elsif user.role?    :twelve
      can :read, :all
    else
      can :read, :all
    end

    # [:read, :create, :update, :destroy], [Model, Model, Model]
    
  end
end
