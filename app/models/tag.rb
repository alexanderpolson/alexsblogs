class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles
  
  def self.sanitize(name)
    name.downcase.strip
  end
  
  def name=(name)
    # Cleanup tag
    write_attribute(:name, Tag.sanitize(name))
  end
  
  def to_s
    self.name
  end
end
