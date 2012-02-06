class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    create_table :articles_tags do |t|
      t.integer :article_id
      t.integer :tag_id
    end
  end
end
