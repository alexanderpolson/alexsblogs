class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.integer :blog_id
      t.integer :article_id

      t.timestamps
    end
  end
end
