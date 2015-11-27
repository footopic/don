class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :article, index: true, null: false, foreign_key: true
      t.string :text, null: false

      t.timestamps null: false
    end

    add_index :comments, [:user_id, :article_id]
    add_index :comments, [:article_id, :user_id]
  end
end
