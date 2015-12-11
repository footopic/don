# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ActiveRecord::Base
  mount_uploader :file, ImageUploader
end
