FactoryGirl.define do
  factory :user do
    uid '12345678'
    provider 'google_oauth2'
    screen_name 'eri'
    name 'エリザベート・バートリー'
    image File.open(File.join(Rails.root, 'spec/factories/sample.jpg'))
  end
end
