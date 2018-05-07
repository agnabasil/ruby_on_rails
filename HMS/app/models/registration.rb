class Registration < ActiveRecord::Base
  
  belongs_to :patient
  belongs_to :bed
  
end
