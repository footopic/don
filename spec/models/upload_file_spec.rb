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

require 'rails_helper'

RSpec.describe UploadFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
