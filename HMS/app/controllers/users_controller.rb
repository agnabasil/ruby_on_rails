class UsersController < ApplicationController
  
  before_filter :authenticate_user, :only => [:home]
  before_filter :save_login_state, :only => [:login, :login_attempt]
  
  def login
    #Login Form
  end
  
  def login_attempt
    authorized_user = User.authenticate(params[:user][:username],params[:user][:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome back, logged in as #{authorized_user.name}"
      redirect_to root_path 
    else
      flash[:notice] = "Invalid Username or Password"
      redirect_to login_users_path  
    end
  end
  
  def logout
    session[:user_id] = nil
    @login_user = ''
    @logged_in = false
    redirect_to login_users_path  
  end
  
  def home
    @current_user = User.find session[:user_id]
    if @current_user.type.to_s == "Admin"
      redirect_to admins_path   
    elsif @current_user.type.to_s == "Doctor"
      redirect_to doctors_path  
    else
      redirect_to patients_path 
    end
    
  end
  
end
