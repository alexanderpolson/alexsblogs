class Login
  attr_reader :email_address, :password
  
  def initialize(login_map)
    @email_address = login_map[:email_address]
    @password = login_map[:password]
  end
    
  def to_s
    "Login<email_address=\"#{self.email_address}, password=\"#{self.password}\">"
  end
end