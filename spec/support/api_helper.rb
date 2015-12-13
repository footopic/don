module ApiHelper
  shared_examples_for 'shared' do
    it '200が返ってくる' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end
  end
end
