class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      
      t.references :patient
      t.references :bed
      t.datetime :start_time
      t.datetime :end_time
      
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
