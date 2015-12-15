require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Comments', type: :request do
  describe 'GET /api/v1/comments' do
    let(:path) { '/api/v1/comments' }
    before do
      @comment = create(:comment)
      get path, comment_id: @user.id
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '取得データの構造は正しいこと' do
      @json = JSON.parse(response.body)
      expect(@json['id']).to eq @user.id
      expect(@json['created_at']).to eq @user.created_at.as_json
      expect(@json['updated_at']).to eq @user.updated_at.as_json
      expect(@json['screen_name']).to eq @user.screen_name
      expect(@json['provider']).to eq @user.provider
      expect(@json['uid']).to eq @user.uid
      expect(@json['name']).to eq @user.name
      expect(@json['article_count']).to eq @user.articles.recently_create.count
    end

    it 'user_id, uid での取得が出来る' do
      @json = JSON.parse(response.body)
      get path, uid: @user.uid
      @json2 = JSON.parse(response.body)
      expect(@json).to eq @json2
    end
  end

  describe 'GET /api/v1/users' do
    let(:path) { '/api/v1/users' }
    before do
      @users = create_list(:user, 3)
      get path
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '一覧の取得' do
      @json = JSON.parse(response.body)
      expect(@json.size).to eq @users.count
      expect(@json[0]['id']).to eq @users[0].id
    end
  end
end
