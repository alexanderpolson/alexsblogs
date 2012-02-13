class Blog < ActiveRecord::Base
  has_many :blog_articles
  has_many :articles, through: :blog_articles
end
