class Comment < ActiveRecord::Base
  validates_presence_of :commenter , :body ,:message=>"feild cannot be empty"
  belongs_to :blog
end
