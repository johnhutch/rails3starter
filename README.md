Tinder gets you started. 
========================

Current version: Rails 3.2.11

Tinder currently includes:
--------------------------

* Devise authentication 
* CanCan authorization based on user roles
* Blogging with comments using Redcarpet markdown
* Rspec and capybara tests with guard and launchy for on-the-fly testing and debugging
* formalize UI
* modernizr JS library for handling old browsers
* HTML5 markup with responsive grid-based layout

Things to do when launching a new site with Tinder
--------------------------------------------

* Update initial settings in /config/settings.yml and each setting file in /config/settings/*.yml
* Create git-ignored local settings (such as omniauth keys and secrets) with /config/settings/<environment>.local.yml
* Add your capistrano deploy script

TO DO
=====

1. Adjust SUSY responsive grid (note sign-in columns need to unfloat at small screen sizes)
2. Fix user account deletion to also delete authentication (and thus allow them to re-sign up with the same auth without the serialize error)
3. Add railscast's jquery batch image uploader
4. Create admin page
5. Create site activity widget:

        Post.includes(:comments).where("comments.create_at > ?", …) 

    or, in rails 4

        Post.includes(:comments).order("comments.created_at")

