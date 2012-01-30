class User < ActiveRecord::Base
  # TODO: One-way encrypt the password using String#crypt. Will need to also store a salt
  # TODO: Make sure email address is unique.
  
  def to_s
    "User<email_address=\"#{self.email_address}\">"
  end
end
