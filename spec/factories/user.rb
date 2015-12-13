FactoryGirl.define do
  sequence(:uid) { |n| n }
  sequence(:name) { |n| "ユーザー-#{n}" }
  sequence(:screen_name) { |n| "name_id_#{n}" }

  factory :user do
    provider 'test'
    uid
    name
    screen_name
    after(:create) do |user|
      3.times { create(:article, user: user) }
    end
  end
end