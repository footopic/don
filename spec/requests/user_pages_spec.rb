require 'rails_helper'

RSpec.describe 'ユーザページ', type: :request do
  let(:user) { create(:user) }

  context 'ログインしている場合' do
    before do
      login user
    end

    it 'ユーザ一覧が表示されること' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  context 'ログインしていない場合' do
    it 'リダイレクトされること' do
      get users_path
      expect(response).to have_http_status(302)
    end
  end
end
