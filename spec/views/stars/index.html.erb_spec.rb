require 'rails_helper'

RSpec.describe "stars/index", type: :view do
  before(:each) do
    assign(:stars, [
      Star.create!(),
      Star.create!()
    ])
  end

  it "renders a list of stars" do
    render
  end
end
