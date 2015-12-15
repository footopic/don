require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Tags', type: :request do
  describe 'POST /api/v1/tags' do
    let(:path) { '/api/v1/tags' }
    before do
      @article = create(:article)
      @tag = 'new_tag'
      post path, { article_id: @article.id, tag: @tag }
    end

    it '201が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'タグが追加されている' do
      @article.tag_list << @tag
      @json = JSON.parse(response.body)
      expect(@json).to eq @article.tag_list
    end
  end

  describe 'DELETE /api/v1/tags' do
    let(:path) { '/api/v1/tags' }
    before do
      @article = create(:article)
      @tag = @article.tag_list[0]
      delete path, { article_id: @article.id, tag: @tag }
    end

    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'タグが削除されている' do
      @article.tag_list.delete(@tag)
      @json = JSON.parse(response.body)
      expect(@json).to eq @article.tag_list
    end
  end
end
