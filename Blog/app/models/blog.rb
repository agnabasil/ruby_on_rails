class Blog < ActiveRecord::Base 

  validates_presence_of :name ,:message=>"feild cannot be empty"
  validates_presence_of :content ,:message=>"feild cannot be empty"
  validates_uniqueness_of :name
  validates_presence_of :author ,:message=>"feild cannot be empty"
  has_many :comments
  
  
  has_attached_file :photo, :styles => { :small => "100x100>" },
    :url  => "/assets/blogs/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/blogs/:id/:style/:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/png','application/pdf']
  
  def validate
    self.errors.add(:author, " name is too big, maximum length allowed is \"20\"") if self.author.length >20
    check_content_field
  end
  
  def check_content_field
    if self.content.length > 100 
      self.errors.add(:content, " is too big, maximum length allowed is \"100\"")
      return false
    elsif self.content.length < 4
      self.errors.add(:content, " is too short, minimum length allowed is \"4\"")
      return false
    end 
  end
  
end
