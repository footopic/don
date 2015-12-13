require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  describe '一覧に遷移したとき' do
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

    it '自分のスクリーンネームをクリックしたときマイページに遷移すること' do
      within('.users') do
        click_link(user.screen_name)
        expect(current_path).to eq user_path(user)
      end
    end

    it '自分の名前があること' do
      within('.users') do
        expect(page).to have_content(user.name)
      end
    end

    context '別のユーザがいるとき' do
      let!(:other) { create(:other_user) }
      before do
        visit users_path
      end

      it '他のユーザの名前があること' do
        expect(page).to have_content(other.name)
      end

      it '他のユーザのスクリーンネームをクリックしたときそのユーザページに遷移すること' do
        within('.users') do
          click_link(other.screen_name)
          expect(current_path).to eq user_path(other)
        end
      end

      context '他のユーザが退会したとき' do
        before do
          other.destroy
          visit users_path
        end

        it '他のユーザの名前がないこと' do
          expect(page).not_to have_content(other.name)
        end
      end
    end
  end
end
