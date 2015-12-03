# == Schema Information
#
# Table name: upload_files
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UploadFile < ActiveRecord::Base
  mount_uploader :file, ImageUploader
end
