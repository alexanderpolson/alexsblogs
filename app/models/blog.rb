class Blog < ActiveRecord::Base
  has_many :blog_articles
  has_many :articles, through: :blog_articles
  
  def finalized_articles
    # TODO: Adjust this such that the logged in author can see their draft posts too.
    self.articles.where(is_draft: false || nil)
  end
  
end
