require 'rails_helper'

RSpec.describe "Stars", type: :request do
  describe "GET /stars" do
    it "works! (now write some real specs)" do
      get stars_path
      expect(response).to have_http_status(200)
    end
  end
end
