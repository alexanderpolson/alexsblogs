module ArticlesHelper
  
  TAG_PATTERN = /^<.*>$/
  BLANK_PATTERN = /^$/
  
  def format_article_line(line)
    if(TAG_PATTERN.match(line) || BLANK_PATTERN.match(line))
      return line
    else
      return "<p>#{line}</p>"
    end
  end
end
