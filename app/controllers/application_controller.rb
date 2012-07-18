class ApplicationController < ActionController::Base
  protect_from_forgery

# # for debugging Ability access issues
# rescue_from CanCan::AccessDenied do |exception|
#   Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
# end  

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
end
