class User < ActiveRecord::Base
  # Relationship for Role model
  has_and_belongs_to_many :roles
  has_many :comments
  has_many :posts
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :confirmed_at, :remember_me

  # Accessor function for retrieving a user's roles
  def role?(role)
      return !!self.roles.find_by_name(role.to_s)
  end

end
