class CommentsController < ApplicationController

  before_filter :authenticate_user, :only => [:comment, :index, :new, :show, :edit]
  
  
  def index
    @blog = Blog.find(params[:blog_id])
    @comments = @blog.comments
    @commenters = User.find(session[:id])
  end

  def show
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
  end

  def new
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build
    @commenters = User.find(session[:id])
  end
  
  def create
    @blog = Blog.find(params[:blog_id])
    @blog_comment = @blog.comments.build(params[:comment])
    @commenters = User.find(session[:id])
    
    if request.xhr?
      
      if session[:id].present?
        
        if @blog_comment.save
          flash[:message] = "Successfully created a new comment."
          @blog = @blog_comment.blog
          @comments = @blog.comments
          @comment = Comment.new
          @commenters = User.find(session[:id])
          
          render :update do |page|
            page.replace_html "comment_form", :partial=>"comment_form"
            page.replace_html "comments-list", :partial=>"comment_list"
          end
          
        else
          render :action => "new"
        end
        
      else
        redirect_to log_in_users_path
      end
      
    end
    
  end

  
  def edit
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @commenters = User.find(session[:id])
  end

  
  def update
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    if session[:id].present?
      if @comment.update_attributes(params[:comment])
        flash[:notice] = "Successfully updated the post."
        #redirect_to blog_comment_url(@blog, @comment)
        render :update do |page|
            page.redirect_to blog_comment_url(@blog, @comment)
          end
      else
        render :action => "edit"
      end
    else
      redirect_to log_in_users_path
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    redirect_to blog_comments_path(@blog) if @comment.destroy
  end

end
