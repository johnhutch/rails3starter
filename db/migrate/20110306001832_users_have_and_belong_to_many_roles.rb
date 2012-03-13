class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
    
    # Add the Tinder user roles to the database table
    admin_role =      Role.create(:name => "admin")
    editor_role =     Role.create(:name => "editor")
    commenter_role =  Role.create(:name => "commenter")
    sponsor_role =    Role.create(:name => "sponsor")
    hopeful_role =    Role.create(:name => "hopeful")
    twelve_role =     Role.create(:name => "twelve")
    
    # Create default admin users
    user = User.create do |u|
      u.email = "jonathan.edward.hall@gmail.com"
      u.password = u.password_confirmation = "chester"
      u.confirmed_at = Time.now
    end
    
    # Assign roles to default admin user
    user.roles << admin_role
    
    # Create default admin users
    user = User.create do |u|
      u.email = "johnhutch@gmail.com"
      u.password = u.password_confirmation = "chester"
      u.confirmed_at = Time.now
    end
    
    # Assign roles to default admin user
    user.roles << admin_role
    
  end

  def self.down
    drop_table :roles_users
  end
end