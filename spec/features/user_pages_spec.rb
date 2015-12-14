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

    it '投稿数が0であること' do
      within('.users') do
        expect(page).to have_content(0)
      end
    end

    context '記事を作成したとき' do
      let!(:article) { create(:article, user: user) }
      before do
        visit users_path
      end

      it '投稿数が1になること' do
        within('.users') do
          expect(page).to have_content(1.to_s)
        end
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

  describe 'ユーザページに遷移したとき' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit user_path(user)
    end

    it 'タイトルが正しいこと' do
      expect(page).to have_title("#{user.screen_name} - 丼")
    end
  end

  describe 'ユーザ設定ページに遷移したとき' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit edit_user_path(user)
    end

    it 'タイトルが正しいこと' do
      expect(page).to have_title('ユーザ設定 - 丼')
    end
  end
end
