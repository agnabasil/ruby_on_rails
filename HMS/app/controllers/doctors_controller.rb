class DoctorsController < ApplicationController
  filter_access_to :all
  def index
    @doctor=Doctor.find(session[:user_id])
  end
  
  
  def new
    @current_user = User.find session[:user_id]
    @doctor = Doctor.new
    
  end
  
  def create
    
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      flash[:notice] = "Created doctor successfully"
      redirect_to admins_path
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
     
  end
  
  def edit
    @doctor = Doctor.find(params[:id])
  end
  
  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      redirect_to doctors_path
    else
      render :edit
    end
  end
  
  def destroy
    @doctor = Doctor.find(params[:id])
  	@doctor.destroy
		redirect_to view_doctor_admins_path
	end
  
  def view_appointments
    @doctor=Doctor.find(params[:id])
    @appointments=@doctor.appointments.all(:order=>"appointment_date")
  end
  
end
