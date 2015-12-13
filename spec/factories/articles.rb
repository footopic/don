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
#
# Indexes
#
#  index_articles_on_title    (title)
#  index_articles_on_user_id  (user_id)
#

FactoryGirl.define do
  sequence :title do
    FFaker::Lorem.sentence
  end

  sequence :text do
    FFaker::HTMLIpsum.body
  end

  factory :article do
    title
    text
    user
  end
end
