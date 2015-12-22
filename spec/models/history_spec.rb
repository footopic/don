# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diff       :string
#
# Indexes
#
#  index_histories_on_article_id              (article_id)
#  index_histories_on_user_id                 (user_id)
#  index_histories_on_user_id_and_article_id  (user_id,article_id)
#

require 'rails_helper'

RSpec.describe History, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:article) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:article) }
  end
end
