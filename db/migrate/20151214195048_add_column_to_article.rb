class AddColumnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :status, :string
  end
end
