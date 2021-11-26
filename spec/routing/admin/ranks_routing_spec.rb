require "rails_helper"

RSpec.describe Admin::RanksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/ranks").to route_to("admin/ranks#index")
    end

    it "routes to #new" do
      expect(get: "/admin/ranks/new").to route_to("admin/ranks#new")
    end

    it "routes to #show" do
      expect(get: "/admin/ranks/1").to route_to("admin/ranks#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/ranks/1/edit").to route_to("admin/ranks#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/ranks").to route_to("admin/ranks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/ranks/1").to route_to("admin/ranks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/ranks/1").to route_to("admin/ranks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/ranks/1").to route_to("admin/ranks#destroy", id: "1")
    end
  end
end
