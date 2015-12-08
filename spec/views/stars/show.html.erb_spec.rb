require 'rails_helper'

RSpec.describe "stars/show", type: :view do
  before(:each) do
    @star = assign(:star, Star.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
