class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    render :text => request.env["omniauth.auth"].to_yaml
  end

  def destroy
  end
end
