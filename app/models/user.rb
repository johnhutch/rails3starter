class User < ActiveRecord::Base
    has_many :authentications
    has_and_belongs_to_many :roles
    has_many :comments
    has_many :posts
    has_many :photos

    after_create :set_initial_roles

    # Include default devise modules. Others available are:
    # :token_authenticatable, :lockable, :timeoutable and :activatable
    devise :database_authenticatable, :registerable, :omniauthable,
        :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :confirmed_at, :remember_me

    # Accessor function for retrieving a user's roles
    def role?(role)
        return !!self.roles.find_by_name(role.to_s)
    end

    def self.from_omniauth(omniauth)
        user = User.new
        user.name ||= omniauth['info']['nickname']
        user.email ||= omniauth['info']['email']
        user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
        user
    end

    def password_required?
        super && authentications.empty?
    end

    def update_with_password(params, *options)
        if encrypted_password.blank?
            update_attributes(params, *options)
        else
            super
        end
    end

    def self.new_with_session(params, session)
        if session["devise.user_attributes"]
            new(session["devise.user_attributes"], without_protection: true) do |user|
                user.attributes = params
                user.valid?
                user.authentications.build(session["devise.auth_attributes"])
            end
        else
            super
        end
    end

    private
    def set_initial_roles
        self.roles << Role.find_by_name("nobody")
        self.roles << Role.find_by_name("commenter")
        self.roles << Role.find_by_name("author")
        self.roles << Role.find_by_name("uploader")
    end
end
