source 'http://rubygems.org'

gem 'rails', '3.2.12'

group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'compass-rails'
  gem 'bootstrap-sass'
  gem 'autoprefixer-rails'
  gem 'susy'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.3.0'
  gem 'jquery-fileupload-rails'
end

gem 'jquery-rails', '~> 2.0.2'
gem 'simple_form'
gem 'mysql2'
gem 'capistrano'
gem 'json'
gem 'therubyracer' # added to avoid javascript errors on deploy

gem 'cancan', '~> 1.6.8'
gem 'devise', '~> 2.2.3'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem 'redcarpet'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'
gem 'rails_config'
gem 'stamp'

group :development, :test do
    gem 'sqlite3'
    gem 'rspec-rails'
    gem 'letter_opener'
    gem 'thin'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'meta_request'
end

group :test do
    gem 'factory_girl'
    gem 'factory_girl_rails', :require => false
    gem 'capybara'
    gem 'selenium-webdriver'
    gem 'guard-rspec'
    gem 'spring'
    gem 'guard-spring'
    gem 'launchy'
    gem 'rb-fsevent' # mac-only gem for guard auto-detect. remove if on another OS
    gem 'database_cleaner'
end
