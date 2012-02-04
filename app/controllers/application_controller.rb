class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def logged_in?
    # TODO: This obviously needs to be made more robust
    session[:author_id]
  end
  
  def require_login
    logger.debug("author Id: #{session[:author_id]}")
    unless logged_in?
      flash[:error] = 'You must be logged in to access this resource.'
      # TODO: Keep track of where the author came from so once logged in they can be returned there (better than it being provided).
      logger.debug("Session: #{session}")
      # TODO: Figure out routes so I can just do login_path instead
      redirect_to '/login'
    end
  end
  
end
