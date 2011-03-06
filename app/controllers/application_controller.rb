class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  
  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Access denied!"  
    redirect_to root_url  
  end
end
