class AddNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    
    # Add the Tempe12 user roles to the database table
    admin_role =      Role.create(:name => "admin")
    uploader_role =     Role.create(:name => "uploader")
    author_role =    Role.create(:name => "author")
    commenter_role =  Role.create(:name => "commenter")
    
    # Create default admin users
    user = User.create do |u|
      u.email = "johnhutch+admin@gmail.com"
      u.password = u.password_confirmation = "chester"
      u.name = "Hutch"
    end
    
    # Assign roles to default admin user
    user.roles << admin_role
    user.roles << author_role
    user.roles << uploader_role
    user.roles << commenter_role
  end

  def self.down
    remove_column :users, :name
  end
end
