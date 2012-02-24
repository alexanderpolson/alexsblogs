class Article < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :tags
  has_many :blog_articles
  has_many :blogs, through: :blog_articles
  
  def formatted_tags
    self.tags.join(', ')
  end
  
  def formatted_tags=(tags_string)
    # First split by the delimiter
    tags = tags_string.split(',')
    
    # Clear the current tags on the article and start
    # from scratch
    self.tags.clear
    
    # Add the tags back
    tags.each do |tag_s|
      
      # Make sure the tag has an entry in the database
      tag = Tag.find_by_name(Tag.sanitize(tag_s))
      if(!tag)
        tag = Tag.new
        tag.name = tag_s
        tag.save
      end
      
      self.tags << tag
    end
  end
  
  def posted_to(blog)
    blog.id
  end
  
  def to_s
    puts("Article<title=#{self.title}, tags=#{self.tags}, body=#{body}>")
  end
end
