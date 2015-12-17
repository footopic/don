class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.references :user, index: true, null: false, foreign_key: true

      t.timestamps null: false
    end

    add_index :templates, :title
  end
end
