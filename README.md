Tinder gets you started. 
========================

Current version: Rails 3.2.8

Tinder currently includes:
--------------------------

* Devise authentication 
* CanCan authorization based on user roles
* Blogging with comments using Redcarpet markdown
* Rspec and capybara tests with guard and launchy for on-the-fly testing and debugging
* formalize UI
* modernizr JS library for handling old browsers
* HTML5 markup with responsive grid-based layouta

Things when launching a new site with Tinder
--------------------------------------------

* Update initial admin user in /db/migrate/20120325060320_add_name_to_user.rb 
* Copy /config/intializers/omniauth_example.rb to /config/initializers/omniauth.rb and update OAuth keys with your respective keys.
* Remove omniauth line from .gitignore
* Add your capybara deploy script
