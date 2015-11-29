class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :provider, null: false, default: ''
      t.string :uid, null: false
      t.string :screen_name, null: false, default: '', unique: true
      t.string :name, null: false, default: ''
      t.string :image

      t.timestamps null: false
    end

    add_index :users, :screen_name, unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
