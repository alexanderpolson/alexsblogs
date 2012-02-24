class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :setup
  
  def current_author_id
    session[:author_id]
  end
  
  def logged_in?
    # TODO: This obviously needs to be made more robust
    current_author_id
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
  
  def active_blog
    @active_blog
  end
  
  private
  #
  # Populate member variables that should populated for all controllers/actions
  #
  def setup
    @active_blog = determine_active_blog
  end
  
  def determine_active_blog
    # Find the part of the URL between '://' and the next '/'.
    # http://alexpolson.com/ => alexpolson.com
    active_blog = nil
    Blog.all.each do |blog|
      pattern = Regexp.new(blog.url_pattern)
      if(pattern.match(request.host))
        logger.info("#{request.host} matches pattern for #{blog.title} (#{blog.url_pattern})")
        active_blog = blog
        break
      end
    end
    
    # Use the default blog
    if(!active_blog)
      logger.info("#{request.host} doesn't match any blog url patterns. Using the default blog.")
      active_blog = default_blog
    end
    
    active_blog
  end
  
  def default_blog
    # TODO: Come up with a configurable way to do this
    # For now just get the first blog
    Blog.first || Blog.new
  end
  
end
