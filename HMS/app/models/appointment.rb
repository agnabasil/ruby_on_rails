class Appointment < ActiveRecord::Base
  
  before_save :save_end_date
  belongs_to :doctor
  belongs_to :patient
 
  def save_end_date
    self.end_date = self.appointment_date.to_time+self.duration.minutes
  end
  
end
