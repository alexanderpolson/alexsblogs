class Blog < ActiveRecord::Base
  has_many :blog_articles
  has_many :articles, through: :blog_articles, order: 'created_at DESC'
  
  def finalized_articles
    self.articles.where('is_draft = false')
  end
  
  def rss_link
    # TODO: This should be updated to use something like blogs_path(...)
    # I was unable to find documented options.
    "/blogs/#{self.id}.rss"
  end
  
  def to_s
    self.title
  end
  
end
