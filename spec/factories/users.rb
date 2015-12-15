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

FactoryGirl.define do

  sequence :uid do |n|
    "#{n}"
  end

  sequence :name do
    FFaker::Name.name
  end

  sequence :screen_name do |n|
    "screen_name_#{n}"
  end

  factory :user do
    uid
    provider 'google_oauth2'
    screen_name
    name
    image File.open(File.join(Rails.root, 'spec/factories/sample.jpg'))
  end

  factory :user_eri do
    uid '12345678'
    provider 'google_oauth2'
    screen_name 'eri'
    name 'エリザベート・バートリー'
    image File.open(File.join(Rails.root, 'spec/factories/sample.jpg'))
  end

  factory :user_toshino do
    uid '123456789'
    provider 'google_oauth2'
    screen_name 'toshino'
    name '歳納京子'
    image File.open(File.join(Rails.root, 'spec/factories/sample.jpg'))
  end

  factory :other_user, class: User do
    sequence(:uid) { |n| "#{n * 10}" }
    provider 'google_oauth2'
    screen_name
    name
    image File.open(File.join(Rails.root, 'spec/factories/sample.jpg'))
  end
end
