require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'cancan/matchers'
  require "paperclip/matchers" 
  require "factory_girl"
  
  Capybara.javascript_driver = :webkit

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
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

  end
end

Spork.each_run do
  require "factory_girl_rails"
  ActiveSupport::Dependencies.clear

  # This code will be run each time you run your specs.
  RSpec.configure do |config|
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
    page.should have_content(I18n.t('flash.signed_in'))
  end
end
