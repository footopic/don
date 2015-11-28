class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :user, index: true, null: false, foreign_key: true

      t.timestamps null: false
    end

    add_index :articles, :title
  end
end
