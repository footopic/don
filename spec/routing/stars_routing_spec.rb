require 'rails_helper'

RSpec.describe StarsController, type: :routing do
  describe 'routing' do

    it 'routes to #create' do
      expect(:post => '/stars').to route_to('stars#create')
    end
    it 'routes to #destroy' do
      expect(:delete => '/stars/1').to route_to('stars#destroy', :id => '1')
    end

  end
end
