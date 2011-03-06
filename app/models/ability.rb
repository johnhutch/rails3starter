class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user if not logged in
    
    if user.role?     :admin
      can               :manage,    :content
      can               :manage,    :user
    
    elsif user.role?  :editor
      can               :read,      :user
    
    elsif user.role?  :commenter
      can               :read,      :user
    
    elsif user.role?  :sponsor
      can               :read,      :user
    
    elsif user.role?  :hopeful
      can               :read,      :user
    
    elsif user.role?  :twelve
      can               :read,      :user
    
    else              # guest
      can               :read,      :all
    end

    # [:read, :create, :update, :destroy], [Model, Model, Model]
    
    # can :update, Comment do |comment|  
    #         comment.try(:user) == user
    
  end
end
