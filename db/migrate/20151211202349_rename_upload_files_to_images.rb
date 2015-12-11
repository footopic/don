class RenameUploadFilesToImages < ActiveRecord::Migration
  def change
    rename_table :upload_files, :images
  end
end
