require 'rails_helper'

RSpec.feature "Sidebars", type: :feature do
  before do
    visit root_path
  end

  context 'ログインしている場合' do
    context 'WRITEボタンをクリックしたとき' do
    end

    context 'ARTICLESボタンをクリックしたとき' do
    end

    context 'MEMBERSボタンをクリックしたとき' do
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
