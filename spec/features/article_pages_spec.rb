require 'rails_helper'

RSpec.feature "記事", type: :feature do
  context '一覧' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    before do
      login(user)
      visit articles_path
    end

    it '自分の記事が表示されていること' do
      expect(page).to have_content(article.title)
    end
  end

  context '個別記事ページに遷移したとき' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    before do
      login(user)
      visit article_path(article)
    end

    it '記事のタイトルが正しいこと' do
      expect(page).to have_title("#{article.title} - 丼")
    end
  end

  context '記事編集ページに遷移したとき' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    before do
      login(user)
      visit edit_article_path(article)
    end

    it '記事のタイトルが正しいこと' do
      expect(page).to have_title("#{article.title} - 丼")
    end
  end
end
