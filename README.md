Tinder gets you started. 
========================

Current version: Rails 3.2.11 with ruby-1.9.3-p374

Tinder currently includes:
--------------------------

* Devise authentication, with OAuth for social network auth 
* CanCan authorization based on user roles
* Blogging with comments using Redcarpet markdown
* (Soon to be batch) Photo uploading and resizing using Paperclip.
* Rspec and capybara tests with guard and launchy for on-the-fly testing and debugging
* formalize UI for better, more consistent form styling.
* Compass SASS mixins with the normalize, SUSY grids, and HTML5 Boilerplate.
* modernizr JS library for handling old browsers

Things to do when launching a new site with Tinder
--------------------------------------------

* Update initial settings in /config/settings.yml and each setting file in /config/settings/*.yml
* Create git-ignored local settings (such as omniauth keys and secrets) with /config/settings.local.yml
* Adjust your capistrano deploy script
* Remove this README from app/views/contents/front.html.erb

* * *

### TO DO

1. Adjust SUSY responsive grid (note sign-in columns need to unfloat at small screen sizes)
2. Fix user account deletion to also delete authentication (and thus allow them to re-sign up with the same auth without the serialize error)
3. Add railscast's jquery batch image uploader
4. Create admin page
5. Create better default capistrano script
6. Create site activity widget:

        Post.includes(:comments).where("comments.create_at > ?", …) 

    or, in rails 4

        Post.includes(:comments).order("comments.created_at")

* * * 
