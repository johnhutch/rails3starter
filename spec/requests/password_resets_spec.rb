require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link I18n.t('links.forgot_password')
    fill_in "Email", :with => user.email
    click_button I18n.t('buttons.reset_password')
    current_path.should eq(new_user_session_path)
    page.should have_content( I18n.t('devise.passwords.send_instructions') )
    last_email.to.should include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit new_user_session_path
    click_link I18n.t('links.forgot_password')
    fill_in "Email", :with => "nobody@example.com"
    click_button I18n.t('buttons.reset_password')
    page.should have_content( I18n.t('errors.messages.not_found') )
    last_email.should be_nil
  end

  it "throws an error when reset passwords do not match" do
    user = FactoryGirl.create(:user, :reset_password_token => "something", :reset_password_sent_at => 1.hour.ago)
    visit edit_user_password_path(:reset_password_token => user.reset_password_token, :method => :put)
    fill_in "New password", :with => "foobar"
    fill_in "Confirm new password", :with => "foobarrrr"
    click_button I18n.t('buttons.change_password')
    page.should have_content("Password doesn't match confirmation")
  end

  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user, :reset_password_token => "something", :reset_password_sent_at => 1.hour.ago)
    visit edit_user_password_path(:reset_password_token => user.reset_password_token, :method => :put)
    fill_in "New password", :with => "foobar"
    fill_in "Confirm new password", :with => "foobar"
    click_button I18n.t('buttons.change_password')
    page.should have_content(I18n.t('devise.passwords.updated'))
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user, :reset_password_token => "something", :reset_password_sent_at => 15.hours.ago)
    visit edit_user_password_path(:reset_password_token => user.reset_password_token, :method => :put)
    fill_in "New password", :with => "foobar"
    fill_in "Confirm new password", :with => "foobar"
    click_button I18n.t('buttons.change_password')
    page.should have_content( I18n.t('errors.messages.expired') )
  end

  it "raises record not found when password token is invalid" do
    visit edit_user_password_path(:reset_password_token => 'invalid', :method => :put)
    fill_in "New password", :with => "foobar"
    fill_in "Confirm new password", :with => "foobar"
    click_button I18n.t('buttons.change_password')
    page.should have_content('Reset password token is invalid') 
  end
end
