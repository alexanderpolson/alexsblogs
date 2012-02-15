class Blog < ActiveRecord::Base
  has_many :blog_articles
  has_many :articles, through: :blog_articles
  
  def finalized_articles(current_author_id)
    # TODO: Adjust this such that the logged in author can see their draft posts too.
    self.articles.where(
      "is_draft = false or is_draft is null or author_id = :author_id",
      { author_id: current_author_id }
    )
  end
  
end
