class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :user, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :histories, [:user_id, :article_id]
  end
end
