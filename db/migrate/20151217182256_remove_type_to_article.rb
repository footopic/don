class RemoveTypeToArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :type, :string
    remove_column :articles, :template_name, :string
  end
end
