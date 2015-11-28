# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string           default(""), not null
#  uid         :integer          not null
#  screen_name :string           default(""), not null
#  name        :string           default(""), not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:screen_name) }
  it { is_expected.to validate_presence_of(:name) }
end
