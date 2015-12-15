require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Comments', type: :request do
  describe 'GET /api/v1/comments/show' do
    let(:path) { '/api/v1/comments/show' }
    before do
      @comment = create(:comment)
      get path, comment_id: @comment.id
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '取得データの構造は正しいこと' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq @comment.id
      expect(json['created_at']).to eq @comment.created_at.as_json
      expect(json['updated_at']).to eq @comment.updated_at.as_json
      expect(json['user']['id']).to eq @comment.user.id
      expect(json['article']['id']).to eq @comment.article.id
    end
  end

  describe 'GET /api/v1/comments' do
    let(:path) { '/api/v1/comments' }
    before do
      @comments = create_list(:comment, 10)
      get path
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '一覧の取得' do
      json = JSON.parse(response.body)
      expect(json.size).to eq @comments.count
      expect(json[0]['id']).to eq @comments[0].id
    end
  end

  describe 'GET /api/v1/comments/recent' do
    let(:path) { '/api/v1/comments/recent' }
    before do
      @comments = create_list(:comment, 10)
      get path
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '順番は正しいか' do
      json = JSON.parse(response.body)
      expect(json.size).to eq @comments.count
      expect(json[0]['id']).to eq @comments.reverse[0].id
    end
  end
end
