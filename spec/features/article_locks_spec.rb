require 'rails_helper'

RSpec.feature '記事の保護', type: :feature do
  context '自分の記事' do
    let!(:user) { create(:user) }
    context '保護されているとき' do
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

      it 'タグ編集ボタンが表示されること' do
        expect(page).to have_css('#edit_tag')
      end

      it { expect(page).to have_link('記事の保護を解除する') }

      context '解除リンクをクリックしたとき' do
        before do
          click_link '記事の保護を解除する'
        end

        it { expect(page).to have_content('保護を解除しました') }
        it { expect(page).to have_link('記事を保護する') }
      end
    end

    context '保護されていないとき' do
      let!(:article) { create(:article, user: user, lock: false) }

      before do
        login(user)
        visit article_path(article)
      end

      it '編集ボタンが表示されること' do
        within('.article-titles') do
          expect(page).to have_css('.fa-pencil')
        end
      end

      it 'タグ編集ボタンが表示されること' do
        expect(page).to have_css('#edit_tag')
      end

      it { expect(page).to have_link('記事を保護する') }

      context '保護リンクをクリックしたとき' do
        subject { page }
        before do
          click_link '記事を保護する'
        end

        it { is_expected.to have_content('保護しました') }
        it { is_expected.to have_link('記事の保護を解除する') }
        it { is_expected.to have_css('.fa-lock') }
      end
    end
  end

  context '他人の記事' do
    context '保護されていない場合' do
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

      it 'タグ編集ボタンが表示されること' do
        expect(page).to have_css('#edit_tag')
      end

      it '編集画面に遷移すること' do
        within('.article-titles') do
          find('.title a').click
          expect(current_path).to eq edit_article_path(article)
        end
      end
    end

    context '保護されている場合' do
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

      it 'タグ編集ボタンが表示されないこと' do
        expect(page).not_to have_css('#edit_tag')
      end

      it '編集ボタンが表示されないこと' do
          expect(page).to have_css('.fa-lock')
      end
    end
  end
end
