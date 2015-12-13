require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /api/v1/articles/show: article_id' do
    before do
      @article = create(:article)
      get '/api/v1/articles/show', id: @article.id
      @json = JSON.parse(response.body)
    end

    # 200が返ってくる
    it '200 response' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    # 取得データの構造は正しいこと
    it 'object structure' do
      expect(@json['id']).to eq @article.id
      expect(@json['created_at']).to eq @article.created_at.as_json
      expect(@json['updated_at']).to eq @article.updated_at.as_json

      expect(@json['title']).to eq @article.title
      expect(@json['text']).to eq @article.text
    end
  end
end
