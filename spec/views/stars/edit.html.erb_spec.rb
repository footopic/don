require 'rails_helper'

RSpec.describe "stars/edit", type: :view do
  before(:each) do
    @star = assign(:star, Star.create!())
  end

  it "renders the edit star form" do
    render

    assert_select "form[action=?][method=?]", star_path(@star), "post" do
    end
  end
end
