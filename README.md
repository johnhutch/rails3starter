Tinder gets you started. 
========================

Current version: Rails 3.2.15 with ruby-1.9.3-p392

Tinder currently includes:
--------------------------

* Devise authentication, with OAuth for social network auth 
* CanCan authorization based on user roles
* Blogging with comments using Redcarpet markdown
* (Soon to be batch) Photo uploading and resizing using Paperclip.
* Rspec and capybara tests with guard and launchy for on-the-fly testing and debugging
* formalize UI for better, more consistent form styling.
* Compass SASS mixins with the normalize, SUSY grids, and Twitter Bootstrap
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
2. Adjust Bootstrap nav when in small-screen dropdown mode
3. Fix user account deletion to also delete authentication (and thus allow them to re-sign up with the same auth without the serialize error)
4. Fix notification classes (why's it always green?)
5. Style image uploader using the not-basic version of the plugin (see here: http://blueimp.github.com/jQuery-File-Upload/)
6. Create admin page
7. Create better default capistrano script
8. Create site activity widget using public_activity gem
9. Check out cane -- https://github.com/square/cane
10. Improve test code quality via guide at http://betterspecs.org


* * * 
