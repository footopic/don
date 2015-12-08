require 'rails_helper'

RSpec.describe "stars/new", type: :view do
  before(:each) do
    assign(:star, Star.new())
  end

  it "renders new star form" do
    render

    assert_select "form[action=?][method=?]", stars_path, "post" do
    end
  end
end
