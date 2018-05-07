# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :authenticate_user , :except => [:new, :create]
  before_filter { |c| Authorization.current_user = c.current_user }
 
  def current_user
    if session[:user_id]!= nil
      @user=User.find(session[:user_id])
      if @user!=nil
        return @user
      end
    end
  end
  
  protected 
  def authenticate_user
    if session[:user_id]
      @logged_in = true
      # set current user object to @current_user object variable
      @current_user = User.find(session[:user_id]) 
      @login_user = @current_user.name.capitalize
      return true	
    else
      @logged_in = false
      redirect_to(:controller => 'users', :action => 'login')
      return false
    end
  end
  
  
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'users', :action => 'home')
      return false
    else
      return true
    end
  end
  
  

  
end
