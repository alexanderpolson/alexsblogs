xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @blog.title
    xml.description @blog.description
    xml.link blog_url(@blog)

    @blog.finalized_articles.limit(10).each do |article|
      xml.item do
        xml.title article.title
        xml.description article.formatted_body
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
