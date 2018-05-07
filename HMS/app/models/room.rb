class Room < ActiveRecord::Base
  
  has_many :beds,:dependent => :destroy
  validates_uniqueness_of :room_no
  validates_presence_of :room_no
  
end
