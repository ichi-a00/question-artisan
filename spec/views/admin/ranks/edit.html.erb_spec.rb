require 'rails_helper'

RSpec.describe "admin/ranks/edit", type: :view do
  before(:each) do
    @admin_rank = assign(:admin_rank, Admin::Rank.create!())
  end

  it "renders the edit admin_rank form" do
    render

    assert_select "form[action=?][method=?]", admin_rank_path(@admin_rank), "post" do
    end
  end
end
