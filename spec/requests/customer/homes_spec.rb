require 'rails_helper'

RSpec.describe "Customer::Homes", type: :request do
  describe "GET /top" do
    it "returns http success" do
      get "/customer/homes/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /ranking" do
    it "returns http success" do
      get "/customer/homes/ranking"
      expect(response).to have_http_status(:success)
    end
  end

end
