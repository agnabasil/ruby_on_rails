class AdminsController < ApplicationController
  filter_access_to :all
  def index
    @current_user = User.find session[:user_id]
    @department = Department.all
    @doctor = Doctor.all
    @patient = Patient.all
    @room = Room.all
    @bed = Bed.all
    @registration = Registration.all
  end
  
  def view_doctor
    @all_doctors=Doctor.all
    @doctors = @all_doctors.sort_by(&:department_id)
   
	end
  
  def view_patient
    @all_patients=Patient.all
    @patients = @all_patients.sort_by(&:name)
	end
  
  def view_bed
    @all_rooms=Room.all
    @rooms = @all_rooms.sort_by(&:room_no)
    @all_beds=Bed.all
    @beds = @all_beds.sort_by(&:bed_no)
    
	end
  
  def new_room
    @room=Room.new
  end
  
  def create_new_room
    @room = Room.new(params[:room])
  	if @room.save
  	  redirect_to view_bed_admins_path
    else
      render :new_room
    end
	end
  
  def delete_room
    @room = Room.find(params[:id])
  	@room.destroy
    redirect_to view_bed_admins_path
  end
  
  def new_bed
    @room = Room.find(params[:id])
    @bed = Bed.new
  end
  
  def create_new_bed
    @bed = Bed.new(params[:bed])
  	if @bed.save		   
  	  redirect_to view_bed_admins_path
   	else
      render :new_bed
    end
  end
      
  def delete_bed
    @bed = Bed.find(params[:id])
    @bed.destroy
    redirect_to view_bed_admins_path
  end
  
  def ajax_bed_view
    room_id=params[:room_id]
    start_time= params[:start_time]
    end_time= params[:end_time] 
    patient_id = params[:patient_id]
    @registrations= Registration.all(:conditions => [ "((? BETWEEN start_time AND end_time )OR (? BETWEEN start_time AND end_time)
      OR(start_time<=? AND end_time>=?)OR(?<=start_time AND ? >=end_time))",
        start_time,end_time,start_time,end_time,start_time,end_time])
    @bed_ids = @registrations.collect(&:bed_id)
    @patients = @registrations.collect(&:patient_id)
    if @patients.present?
      @checkpatient = Registration.all(:conditions => ["patient_id in (?)",patient_id])
    end
    if @checkpatient.present?
      @beds = []
    else
      
    
      if @bed_ids.present?
        @beds=Bed.find(:all,:conditions=>["id NOT in (?) AND room_id in (?)",
            @bed_ids,room_id])
      else
        @beds=Bed.all(:conditions=>["room_id in (?)",room_id])
      end
    end
    render :partial=>'list_free_beds',:locals=>{:patient_id=>params[:patient_id]}
  end
  
  def all_registration
    @registration=Registration.all
      
  end
  
  def new_registration
    @registration=Registration.new
    @patients=Patient.all
    @rooms=Room.all
  end
  
  def create_new_registration
    start_date=DateTime.new(params[:registration]["start_time(1i)"].to_i,
      params[:registration]["start_time(2i)"].to_i,
      params[:registration]["start_time(3i)"].to_i,
      params[:registration]["start_time(4i)"].to_i,
      params[:registration]["start_time(5i)"].to_i)
    end_date=DateTime.new(params[:registration]["end_time(1i)"].to_i,
      params[:registration]["end_time(2i)"].to_i,
      params[:registration]["end_time(3i)"].to_i,
      params[:registration]["end_time(4i)"].to_i,
      params[:registration]["end_time(5i)"].to_i)
    @registration=Registration.new(:patient_id=>params[:registration][:patient_id],
      :bed_id=>params[:registration][:bed_id],
      :start_time=>start_date,:end_time=>end_date)
    if @registration.save
      redirect_to all_registration_admins_path
    else
      render :new_registration
    end
  end
    
  def delete_registration
    @reg = Registration.find(params[:id])
  	@reg.destroy
    redirect_to all_registration_admins_path
  end
  
end
