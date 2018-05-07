require 'bcrypt'
class User < ActiveRecord::Base
  
  include BCrypt
  
  attr_accessor :password
  
  validates_presence_of :username ,:message=>"feild cannot be empty"
  validates_presence_of :password ,:message=>"feild cannot be empty"
  
  has_attached_file :avatar, :styles => { :small => "150x150>", :medium => "300x300>", :thumb => "100x100>" },
    :url  => "/assets/users/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension",
    :use_timestamp => false

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  
  
  def self.authenticate(username=nil, login_password=nil)
    
    user = User.find_by_username(username)
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end
  
  def role_symbols
    return self.type.to_s.underscore.to_sym.to_a
  end
  
  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

end
