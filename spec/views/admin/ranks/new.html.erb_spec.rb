require 'rails_helper'

RSpec.describe "admin/ranks/new", type: :view do
  before(:each) do
    assign(:admin_rank, Admin::Rank.new)
  end

  it "renders new admin_rank form" do
    render

    assert_select "form[action=?][method=?]", admin_ranks_path, "post" do
    end
  end
end
