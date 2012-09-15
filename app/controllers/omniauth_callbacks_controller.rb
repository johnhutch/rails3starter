class OmniauthCallbacksController < ApplicationController
    def all
        omniauth = request.env["omniauth.auth"]
        authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
        if authentication
            flash[:notice] = "Signed in successfully."
            sign_in_and_redirect(:user, authentication.user)
        elsif current_user
            current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
            flash[:notice] = "Authentication successful."
            redirect_to authentications_url
        else
            user = User.from_omniauth(omniauth)
            if user.save
                flash[:notice] = "Signed in successfully."
                sign_in_and_redirect(:user, user)
            else
                flash[:notice] = "Please finalize your registration"
                session["devise.user_attributes"] = user.attributes
                session["devise.auth_attributes"] = user.authentications.first.attributes
                redirect_to new_user_registration_url
            end
        end
    end

    def failure
        flash.notice = "Authentication failure"
        redirect_to new_user_registration_url
        # define me
    end

    alias_method :twitter, :all
end
