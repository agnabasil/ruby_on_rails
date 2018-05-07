class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      
      t.string :type
      t.string :name
      t.integer :age
      t.string :username
      t.string :encrypted_password 
      t.string :salt
      t.references :department

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
