# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  text       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_articles_on_title    (title)
#  index_articles_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to enumerize(:status) }
end
