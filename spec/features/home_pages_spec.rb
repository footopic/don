require 'rails_helper'

RSpec.describe 'トップページ', type: :feather do
  context 'ログインしている場合' do
    let(:user) { create(:user) }

    before do
      login(user)
      visit root_path
    end

    it 'ログインリンクが表示されないこと' do
      expect(page).not_to have_content('ログイン')
    end

    it '自分のスクリーンネームが表示されること' do
      expect(page).to have_content(user.screen_name)
    end

    it 'ログインしてくださいとメッセージが表示されないこと' do
      visit users_path
      expect(page).not_to have_content('ログインまたは登録が必要です')
    end
  end

  context 'ログインしていない場合' do
    it 'ログインリンクが表示されていること' do
      visit root_path
      expect(page).to have_content('ログイン')
    end

    it 'ログインしてくださいとメッセージが表示されること' do
      visit users_path
      expect(page).to have_content('ログインまたは登録が必要です')
    end
  end
end
