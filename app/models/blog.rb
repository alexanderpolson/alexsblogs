class Blog < ActiveRecord::Base
  has_many :blog_articles
  has_many :articles, through: :blog_articles, order: 'created_at DESC'
  
  def finalized_articles
    self.articles.where('is_draft = false')
  end
  
  def to_s
    self.title
  end
  
end
