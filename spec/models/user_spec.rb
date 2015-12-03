# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string           default(""), not null
#  uid         :string           not null
#  screen_name :string           default(""), not null
#  name        :string           default(""), not null
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_screen_name       (screen_name) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:screen_name) }
  it { is_expected.to validate_presence_of(:name) }
end
