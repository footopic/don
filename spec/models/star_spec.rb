# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stars_on_article_id  (article_id)
#  index_stars_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Star, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:article) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:article) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
