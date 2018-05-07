# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  
  
  before_filter :authenticate_user
#  before_filter :fetch_user
  #  @author = User.find(session[:id])
    
    
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected 
  def authenticate_user
    if session[:id].present?
      @logged_in = true
      # set current user object to @current_user object variable
      @current_user = User.find session[:id]
      @login_user = @current_user.username.capitalize
      return true	
    else
      @logged_in = false
      redirect_to(:controller => 'users', :action => 'log_in')
      return false
    end
  end
  
  
  def save_login_state
    if session[:id]
      redirect_to(:controller => 'users', :action => 'log_in')
      return false
    else
      return true
    end
  end
  
end
