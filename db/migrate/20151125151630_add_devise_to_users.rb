class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :provider, null: false, default: ""
      t.integer :uid, null: false
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
