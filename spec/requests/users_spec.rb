require 'spec_helper'

describe "Users" do
  
  let(:user) {FactoryGirl.create(:nobody)}
  describe "GET /users/sign_in" do
    it "displays the login form" do
      visit new_user_session_path
      expect(page).to have_content("Sign in");
    end
  end

  describe "POST /users/sign_in" do
    it "logs the user in" do 
      user
      visit new_user_session_path
      fill_in "sign_in_email", :with => user.email
      fill_in "sign_in_password", :with => user.password
      click_button "Sign in"
      expect(page).to have_content( I18n.t('devise.sessions.signed_in') )
    end
  end

  describe "POST /users/sign_out" do
    it "signs the user out", :js => true do
      login(user)

      click_link user.name
      click_link "Sign out"
      expect(page).to have_content "Signed out successfully."
    end
  end

  describe "GET /users/sign_up" do
    it "displays the signup form" do
      visit new_user_session_path
      expect(page).to have_content("Sign up")
    end
  end

  describe "POST /users/" do 
    it "signs a user up" do
      visit new_user_session_path
      expect(page).to have_content("Sign up")
      fill_in "registration_email", :with => "test@email.com"
      fill_in "registration_password", :with => "secret"
      fill_in "registration_confirm_password", :with => "secret"
      fill_in "registration_name", :with => "New user!"
      click_button "Sign up"
      expect(page).to have_content("New user!")
      expect(page).to have_content( I18n.t('devise.registrations.signed_up') )
    end
  end
end
