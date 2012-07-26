source 'http://rubygems.org'

gem 'rails', '3.2.6'

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.6'
end

gem 'jquery-rails'
gem 'mysql2'
gem 'capistrano'
gem 'json'

gem 'cancan'
gem 'devise'

gem 'redcarpet'
gem 'formalize-rails'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'


group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails' 
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rb-fsevent' # mac-only gem for guard auto-detect. remove if on another OS
  gem 'database_cleaner'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
end
