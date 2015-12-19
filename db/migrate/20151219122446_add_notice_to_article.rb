class AddNoticeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :notice, :boolean, default: true
  end
end
