class Patient < User
  
  has_many :appointments,:dependent => :destroy
  has_many :doctors, :through => :appointments
  has_many :registrations,:dependent => :destroy
  has_many :beds, :through=> :registrations
  validates_presence_of :name
  
  
  before_save :encrypt_password
  after_save :clear_password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def clear_password
    self.password = nil
  end
  
end
