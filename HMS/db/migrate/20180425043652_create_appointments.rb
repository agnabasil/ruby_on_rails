class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      
      t.references :doctor
      t.references :patient
      t.datetime :appointment_date
      t.integer :duration
      t.datetime :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
