require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /api/v1/users/show: uid' do
    before do
      @user = FactoryGirl.create(:user)
      get '/api/v1/users/show', user_id: @user.id
      @json = JSON.parse(response.body)
    end

    # 200が返ってくる
    it '200 response' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    # 取得データの構造は正しいこと
    it 'object structure' do
      expect(@json['id']).to eq @user.id
      expect(@json['created_at']).to eq @user.created_at.as_json
      expect(@json['updated_at']).to eq @user.updated_at.as_json
      expect(@json['screen_name']).to eq @user.screen_name
      expect(@json['provider']).to eq @user.provider
      expect(@json['uid']).to eq @user.uid
      expect(@json['name']).to eq @user.name
    end
  end
end
