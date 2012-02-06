class Article < ActiveRecord::Base
  belongs_to :author
  has_and_belongs_to_many :tags
  
  def formatted_tags
    self.tags.join(', ')
  end
  
  def formatted_tags=(tags_string)
    puts("\n\n\nGot here!!!!\n#{tags_string}\n\n")
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
end
