ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'cancan/matchers'
require "paperclip/matchers" 
require "factory_girl"
require "factory_girl_rails"

ActiveSupport::Dependencies.clear

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.include Capybara::DSL

  config.include(Paperclip)
  config.include(MailerMacros)

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) { reset_email }
  
  config.before(:each) do
    DatabaseCleaner.start
    admin_role =    Role.create(:name => "admin")
    uploader_role =     Role.create(:name => "uploader")
    author_role =    Role.create(:name => "author")
    commenter_role =  Role.create(:name => "commenter")
    nobody_role =  Role.create(:name => "nobody")
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def login(user)
  visit new_user_session_path
  fill_in "sign_in_email", :with => user.email
  fill_in "sign_in_password", :with => user.password
  click_button "Sign in"
  expect(page).to have_content(I18n.t('flash.signed_in'))
end

#Spork.each_run do
#
#  # This code will be run each time you run your specs.
#  RSpec.configure do |config|
#  end
#
#end
