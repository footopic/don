require 'rails_helper'

RSpec.describe 'ナビゲーションバー', type: :feature do
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
      expect(page).to have_link(user.screen_name)
    end

    context 'スクリーンネームをクリックしたとき' do
      subject{ page }

      it { is_expected.to have_link('作成') }
      it { is_expected.to have_link('記事一覧') }
      it { is_expected.to have_link('メンバー') }

      it { is_expected.to have_link('マイページ') }
      it { is_expected.to have_link('設定') }
      it { is_expected.to have_link('ログアウト') }
    end

    context '記事作成ボタンをクリックしたとき' do
      before do
        click_link '作成'
      end

      it '記事作成ページに遷移すること' do
        expect(current_path).to eq new_article_path
      end
    end

    context '記事一覧をクリックしたとき' do
      before do
        click_link '記事一覧'
      end

      it '記事一覧ページに遷移すること' do
        expect(current_path).to eq articles_path
      end
    end

    context 'メンバーボタンをクリックしたとき' do
      before do
        click_link 'メンバー'
      end

      it 'ユーザ一覧ページに遷移すること' do
        expect(current_path).to eq users_path
      end
    end

    it 'マイページをクリックするとユーザページに遷移すること' do
      within '.dropdown-menu' do
        click_link 'マイページ'
      end
      expect(current_path).to eq(user_path(user))
    end

    it '設定をクリックするとユーザ編集ページに遷移すること' do
      within '.dropdown-menu' do
        click_link '設定'
      end
      expect(current_path).to eq(edit_user_path(user))
    end

    it 'ロゴをクリックしたときrootに遷移すること' do
      visit user_path(user)
      click_link '丼'
      expect(current_path).to eq(root_path)
    end

    context 'ログアウトをクリックしたとき' do
      before do
        within '.dropdown-menu' do
          click_link 'ログアウト'
        end
      end

      it 'メッセージが表示されること' do
        expect(page).to have_content('ログアウトしました')
      end

      it 'ルートに遷移すること' do
        expect(current_path).to eq(root_path)
      end
    end

    it 'ログインメッセージが表示されないこと' do
      visit users_path
      expect(page).not_to have_content('ログインまたは登録が必要です')
    end
  end

  context 'ログインしていない場合' do
    it 'ログインリンクが表示されていること' do
      visit root_path
      expect(page).to have_content('ログイン')
    end

    it 'ログインメッセージが表示されること' do
      visit users_path
      expect(page).to have_content('ログインまたは登録が必要です')
    end
  end
end
