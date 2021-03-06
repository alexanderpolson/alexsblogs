class Author < ActiveRecord::Base
  # TODO: One-way encrypt the password using String#crypt. Will need to also store a salt
  # TODO: Make sure email address is unique.
  
  has_many :articles
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def to_s
    "Author<email_address=\"#{self.email_address}\">"
  end
end
