require 'rails_helper'

RSpec.describe 'トップページ', type: :feather do
  context 'ログインしている場合' do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it 'ログインリンクが表示されないこと' do
      visit root_path
      expect(page).not_to have_content('ログイン')
    end
  end

  context 'ログインしていない場合' do
    it 'ログインリンクが表示されていること' do
      visit root_path
      expect(page).to have_content('ログイン')
    end
  end
end
