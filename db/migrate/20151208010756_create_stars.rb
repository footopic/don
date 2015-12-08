class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.references :article, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
