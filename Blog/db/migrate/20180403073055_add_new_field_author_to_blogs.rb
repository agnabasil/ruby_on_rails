class AddNewFieldAuthorToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :author, :string
  end

  def self.down
    remove_column :blogs, :author, :string
  end
end
