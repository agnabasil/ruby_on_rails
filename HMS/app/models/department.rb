class Department < ActiveRecord::Base
  
  has_many :doctors,:dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
  
end
