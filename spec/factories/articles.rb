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
    after(:create) do |article|
      # add tag
      tags = 3.times.map { FFaker::Lorem.word }
      article.update_attributes(tag_list: tags)
      # add comment
      4.times do
        article.comments.create(user_id: article.user.id, text: FFaker::Lorem.sentence)
      end
      # add star
      4.times do
        article.add_star(article.user)
      end
    end
  end

end
