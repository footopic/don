require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  describe 'ユーザページ一覧に遷移したとき' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit users_path
    end

    it '自分のスクリーンネームがあること' do
      within('.users') do
        expect(page).to have_content(user.screen_name)
      end
    end

    it '自分の名前があること' do
      within('.users') do
        expect(page).to have_content(user.name)
      end
    end
  end
end
