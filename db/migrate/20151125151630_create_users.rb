class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :provider, null: false, default: ''
      t.integer :uid, :limit => 8, null: false
      t.string :screen_name, null: false, default: '', unique: true
      t.string :name, null: false, default: ''
    end

  end
end
