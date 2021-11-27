require 'rails_helper'

RSpec.describe "admin/ranks/index", type: :view do
  before(:each) do
    assign(:admin_ranks, [
      Admin::Rank.create!,
      Admin::Rank.create!,
    ])
  end

  it "renders a list of admin/ranks" do
    render
  end
end
