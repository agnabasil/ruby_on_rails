class UsersController < ApplicationController
  
  
  #before filter 
  before_filter :authenticate_user, :only => [:log_out]
  before_filter :save_login_state, :only => [:new, :log_in, :create]
  
  
  def new
    @user = User.new 
  end 
  
  def create 
    @user = User.new(params[:user])
    if @user.save 
      session[:id] = @user.id
      flash[:notice] = "You signed up successfully as #{@user.username} "     
      redirect_to blogs_path
    else 
      flash[:notice] = "Form is invalid"
      render :new
    end
  end
  
  
  
  def log_in
    if request.post?
      if params[:user].present? or params[:user].present?
        authorized_user = User.authenticate(params[:user][:username_or_email],params[:user][:login_password])
        if authorized_user
          session[:id] = authorized_user.id
          flash[:notice] = "Welcome back, #{authorized_user.username}"
          redirect_to blogs_path
        else
          flash.now[:notice] = "Invalid Username or Password"
          render "log_in"	
        end
      else
        flash.now[:notice] = "Blank Username or Password"
        render "log_in"	
      end
    end
  end
  
  def log_out
    session[:id] = nil
    @login_user = ''
    @logged_in = false
    render 'log_in'
  end

end

