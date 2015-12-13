require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Templates', type: :request do
  describe 'GET /api/v1/templates' do
    let(:path) { '/api/v1/templates' }
    before do
      @article = create(:article)
      @article.update_attributes(tag_list: @article.tag_list + ['template'])
      @name = @article.user.name
      @screen_name = @article.user.screen_name
      get path, { name: @name, me: @screen_name }
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '取得データの構造は正しいこと' do
      @json = JSON.parse(response.body)
      @template = @json[0]
      expect(@template['id']).to eq @article.id
      expect(@template['created_at']).to eq @article.created_at.as_json
      expect(@template['updated_at']).to eq @article.updated_at.as_json

      expect(@template['title']).to eq @article.title
      expect(@template['text']).to eq @article.text
    end

    it 'template タグが除かれて返ってくる' do
      @json = JSON.parse(response.body)
      @template = @json[0]
      expect(@template['tags'].include? 'template').to be false
      expect(@template['tags']).to eq @article.tag_list - ['template']
    end

  end
end
