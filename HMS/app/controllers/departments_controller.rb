class DepartmentsController < ApplicationController
  filter_access_to :all
  def index
    
    @departments = Department.all
    
  end
  
  def new
    
    @department = Department.new
    
  end
  
  def create
    
    @department = Department.new(params[:department])
    if @department.save
      flash[:notice] = "Created department successfully"
      redirect_to departments_path
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
    
  end
  
  def show
    
    @department = Department.find(params[:id])
  
  end

  def destroy
  
    @department = Department.find(params[:id])
    if @department.destroy
      redirect_to departments_path
    else
      flash[:notice] = "Unable to delete dapartment"
      render :show
    end
  
  end
  
end
