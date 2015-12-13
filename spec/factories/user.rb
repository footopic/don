FactoryGirl.define do
  sequence(:uid) { |n| n }
  sequence(:name) { |n| "ユーザー-#{n}" }
  sequence(:screen_name) { |n| "name_id_#{n}" }

  factory :user do
    provider 'google_oauth2'
    uid
    name
    screen_name
  end
end