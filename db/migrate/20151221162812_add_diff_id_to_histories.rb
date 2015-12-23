class AddDiffIdToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :diff, :string
  end
end
