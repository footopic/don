class AddBlockColumnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :lock, :boolean, default: false
  end
end
