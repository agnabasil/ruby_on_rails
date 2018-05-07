class PatientsController < ApplicationController
  filter_access_to :all
  def index
    @patient=Patient.find(session[:user_id])
  end
  
  
  def new
    
    @patient = Patient.new
    
  end
  
  def create
    
    @patient = Patient.new(params[:patient])
    if @patient.save
      flash[:notice] = "You signed up successfully"
      redirect_to login_users_path
    else
      flash[:notice] = "Form is invalid"
      render :new
    end
    
  end
  
  def edit
    @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      redirect_to  patients_path
    else
      render 'patients/edit'
    end
  end
  
  def destroy
    @patient = Patient.find(params[:id])
  	@patient.destroy
		redirect_to view_patient_admins_path
	end
  
  def view_appointments
    @patient = Patient.find(params[:id])
    @appointments=@patient.appointments.all
  end
  
  def new_appointment
    @departments=Department.all
    @patient = Patient.find(params[:id])
    @appointment=@patient.appointments.build
  end
  
  def list_available_doctors
    @appointment_date=params[:appoinment_date]
    dept_id=params[:department_id]
    appointment_date= params[:appointment_date]
    end_date= params[:appointment_date].to_time+params[:duration].to_i.minutes
    @department=Department.find(params[:department_id])
    @current_appointments=Appointment.all(:conditions=>[" 
      ((? BETWEEN appointment_date AND end_date ) 
                         OR (? BETWEEN appointment_date AND end_date )
                         OR(appointment_date<=? AND end_date>=?)
                          OR(?<appointment_date AND ? >end_date))",
        appointment_date,end_date,appointment_date,
        end_date,appointment_date,end_date])
        
    @doctor_ids=@current_appointments.collect(&:doctor_id)
    if @doctor_ids.present?
      @doctors=Doctor.find(:all,
        :conditions=>["id NOT in (?) AND department_id = ?",@doctor_ids,dept_id])
    else
      @doctors=Doctor.all(:conditions=>["department_id = ?",dept_id])
    end
    render :partial=>'list_doctors',
      :locals=>{:patient_id=>params[:patient_id],
      :appointment_date=>params[:appointment_date],:dur=>params[:duration]}
  end
  
  def create_new_appointment
    @date=DateTime.new(params[:appointment]["appointment_date(1i)"].to_i,
      params[:appointment]["appointment_date(2i)"].to_i,
      params[:appointment]["appointment_date(3i)"].to_i,
      params[:appointment]["appointment_date(4i)"].to_i,
      params[:appointment]["appointment_date(5i)"].to_i)
    @patient = Patient.find(params[:id])
    @appointment=@patient.appointments.build(:doctor_id=>params[:appointment][:doctor_id],
      :appointment_date=>@date,:duration=>params[:appointment][:duration])
    if @appointment.save
      redirect_to   patients_path
    else
      render :text =>"Appointment Not fixed"
      render :new_appointment
    end
  end
  
  def delete_appointments
    @appo = Appointment.find(params[:id])
  	@appo.destroy
    redirect_to view_appointments_patient_url(session[:user_id])
  end
  
end
