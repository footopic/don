require 'rails_helper'

RSpec.feature '記事のロック', type: :feature do
  context '自分の記事' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user, lock: true) }

    before do
      login(user)
      visit article_path(article)
    end

    it '編集ボタンが表示されること' do
      within('.article-titles') do
        expect(page).to have_css('.fa-pencil')
      end
    end
  end

  context '他人の記事' do
    context 'ロックされていない場合' do
      let!(:user) { create(:user) }
      let!(:other) { create(:user) }
      let!(:article) { create(:article, user: other, lock: false) }

      before do
        login(user)
        visit article_path(article)
      end

      it '編集ボタンが表示されること' do
        within('.article-titles') do
          expect(page).to have_css('.fa-pencil')
        end
      end

      it '編集画面に遷移すること' do
        within('.article-titles') do
          find('.title a').click
          expect(current_path).to eq edit_article_path(article)
        end
      end
    end

    context 'ロックされている場合' do
      let!(:user) { create(:user) }
      let!(:other) { create(:user) }
      let!(:article) { create(:article, user: other, lock: true) }

      before do
        login(user)
        visit article_path(article)
      end

      it '編集ボタンが表示されないこと' do
        within('.article-titles') do
          expect(page).not_to have_css('.fa-pencil')
        end
      end
    end
  end
end
