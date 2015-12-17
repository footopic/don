class AddTypeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :type, :string
    add_column :articles, :template_name, :string

    add_index  :articles, :type
  end
end
