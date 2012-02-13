class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.string :url_pattern

      t.timestamps
    end
  end
end
