require 'rails_helper'

RSpec.describe "Customer::Homes", type: :request do
  describe "GET /top" do
    it "returns http success" do
      expect(FactoryBot.create(:customer)).to be_valid
      expect(FactoryBot.create(:question)).to be_valid
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
