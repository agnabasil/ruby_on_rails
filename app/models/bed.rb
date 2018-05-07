class Bed < ActiveRecord::Base
  
  belongs_to :room
  has_many :registrations
  has_many :patients, :through => :registrations
  validates_uniqueness_of :bed_no
  
end
