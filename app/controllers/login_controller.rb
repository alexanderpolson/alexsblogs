class LoginController < ApplicationController
  def index
    # TODO: There's a better way to do this.
    @logged_in = logged_in?
  end

  # TODO: Figure out how to update routes such that this can be renamed to index.
  def create
    login = Login.new(params[:login])
    user = User.find_by_email_address(login.email_address)
    logger.debug("'got here' #{user}")
    
    # Verify the user exists and the password is correct.
    if(user && login.password == user.password)
      # Setup the session
      session[:user_id] = user.id
      logger.debug("User id: #{user.id}")
      redirect_to(:back)
    else
      redirect_with_login_error
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You are now logged out.'
    redirect_to blog_path
  end
  
  private
  def redirect_with_login_error
    flash[:error] = 'The provided credentials either don\'t exist or are incorrect. Please try again.'
    # TODO: Figure out routes so I can just do login_path instead
    redirect_to '/login'
  end
end
