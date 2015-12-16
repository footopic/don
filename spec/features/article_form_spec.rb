require 'rails_helper'

RSpec.feature '記事の編集フォーム', type: :feature do
  context '新規作成' do
    let!(:user) { create(:user) }
    before do
      login(user)
      visit article_path(article)
    end

  end

  context '更新' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    before do
      login(user)
      visit article_path(article)
    end
  end
end

