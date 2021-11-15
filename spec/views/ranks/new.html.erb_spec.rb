require 'rails_helper'

RSpec.describe "ranks/new", type: :view do
  before(:each) do
    assign(:rank, Rank.new(
      rank: 1,
      experience_point: 1
    ))
  end

  it "renders new rank form" do
    render

    assert_select "form[action=?][method=?]", ranks_path, "post" do

      assert_select "input[name=?]", "rank[rank]"

      assert_select "input[name=?]", "rank[experience_point]"
    end
  end
end
