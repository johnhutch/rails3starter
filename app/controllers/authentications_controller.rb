class AuthenticationsController < ApplicationController
    def index
        @authentications = current_user.authentications if current_user
    end

    def create
        auth = request.env["omniauth.auth"] 
        current_user.authentications.where(:provider => auth['provider'], :uid => auth['uid']).first_or_create
        flash[:notice] = "Authentication successful."
        redirect_to authentications_url
    end

    def destroy
        @authentication = current_user.authentications.find(params[:id])
        @authentication.destroy
        flash[:notice] = "Successfully destroyed authentication."
        redirect_to authentications_url
    end
end
