require 'rails_helper'

RSpec.feature "サイドバー", type: :feature do
  before do
    visit root_path
  end

  context 'ログインしている場合' do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    context 'ARTICLESボタンをクリックしたとき' do
      before do
        find('#side-bar__articles').click
      end

      it '記事一覧を表示' do
        expect(current_path).to eq articles_path
      end
    end

    context 'WRITEボタンをクリックしたとき' do
      before do
        find('#side-bar__write').click
      end

      it '記事作成ページに遷移すること' do
        expect(current_path).to eq new_article_path
      end
    end

    context 'MEMBERSボタンをクリックしたとき' do
      before do
        find('#side-bar__members').click
      end

      it 'ユーザ一覧ページに遷移すること' do
        expect(current_path).to eq users_path
      end
    end
  end

  context 'ログインいない場合' do
    context 'ARTICLESボタンをクリックしたとき' do
      before do
        find('#side-bar__articles').click
      end

      it '記事一覧を表示' do
        expect(current_path).to eq articles_path
      end
    end

    context 'WRITEボタンをクリックしたとき' do
      before do
        find('#side-bar__write').click
      end

      it 'ルートに遷移すること' do
        expect(current_path).to eq root_path
      end

      it 'メッセージが表示されること' do
        expect(page).to have_content('ログインまたは登録が必要です')
      end
    end

    context 'MEMBERSボタンをクリックしたとき' do
      before do
        find('#side-bar__members').click
      end

      it 'ルートに遷移すること' do
        expect(current_path).to eq root_path
      end

      it 'メッセージが表示されること' do
        expect(page).to have_content('ログインまたは登録が必要です')
      end
    end
  end
end
