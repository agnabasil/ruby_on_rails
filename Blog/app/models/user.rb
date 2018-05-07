require 'bcrypt'
class User < ActiveRecord::Base
  
  attr_accessor :password , :password_confirmation
  
  validates_presence_of :username ,:message=>"feild cannot be empty"
  validates_presence_of :email ,:message=>"feild cannot be empty"
  validates_confirmation_of :password ,:message=>"feild should match confirmation"
  validates_presence_of :password_confirmation
  validates_presence_of :password ,:message=>"feild cannot be empty"
  validates_presence_of :address ,:message=>"feild cannot be empty"
  validates_uniqueness_of :username , :email
    
  before_save :encrypt_password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

    
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  #validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  #validates :email, :format => EMAIL_REGEX
  validates_format_of :email,:with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, :message => "Please enter a valid email address"
  #validates_presence_of :password, :password_confirmation#password_confirmation attr
  #validates_length_of :password, :minimum=>4 #:in => 6..20, :on => :create
  
  
  
  
  def self.authenticate(username_or_email=nil, login_password=nil)
    if  EMAIL_REGEX.match(username_or_email) 
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   
  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end
end
