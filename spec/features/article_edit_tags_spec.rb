require 'rails_helper'

RSpec.feature 'タグの編集', type: :feature do
  context '自分の記事' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    before do
      login(user)
      visit article_path(article)
    end

    it { expect(page).to have_link('編集') }
    # TODO: capybara-webkit
    # context 'タグ編集をクリックしたとき' do
    #   before do
    #     click_link 'タグ編集'
    #   end

    #   it { expect(page).to have_css('.add_tag_form', visible: true) }
    #   it do
    #     within('.add_tag_form') do
    #       expect(page).to have_link('完了')
    #     end
    #   end
    # end
  end
end
