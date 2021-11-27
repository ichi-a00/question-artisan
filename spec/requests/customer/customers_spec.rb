require 'rails_helper'

RSpec.describe "Customer::Customers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/customer/customers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/customer/customers/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/customer/customers/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/customer/customers/update"
      expect(response).to have_http_status(:success)
    end
  end
end
