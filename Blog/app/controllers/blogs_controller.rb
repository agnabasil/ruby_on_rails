class BlogsController < ApplicationController

  before_filter :authenticate_user, :only => [:index, :new, :create, :edit, :update, :show, :destroy]

  def index
    @blogs = Blog.all
    @author = User.find(session[:id])
  end

  def new
    @blog = Blog.new
    @author = User.find(session[:id])
  end

  def create
    @blog = Blog.new(params[:blog])
    if session[:id].present?
      if @blog.save 
        flash[:notice] = "Successfully created new a post."
        redirect_to blogs_path
      else
        render :new
      end
    else
      redirect_to log_in_users_path      
    end
  end

  def edit 
    @blog = Blog.find(params[:id])
    @author = User.find(session[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if session[:id].present?
      if @blog.update_attributes(params[:blog])
        flash[:notice] = "Successfully updated the post."
        redirect_to blog_path
      else
        render :edit
      end
    else
      redirect_to log_in_users_path
    end
  end
  
  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments
    @comment = Comment.new 
    @commenters = User.find(session[:id])
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    if session[:id].present?
      if @blog.destroy
        redirect_to(blogs_url) 
      end
    else
      redirect_to log_in_users_path
    end
  end

end