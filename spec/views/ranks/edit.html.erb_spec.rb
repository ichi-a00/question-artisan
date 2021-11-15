require 'rails_helper'

RSpec.describe "ranks/edit", type: :view do
  before(:each) do
    @rank = assign(:rank, Rank.create!(
      rank: 1,
      experience_point: 1
    ))
  end

  it "renders the edit rank form" do
    render

    assert_select "form[action=?][method=?]", rank_path(@rank), "post" do

      assert_select "input[name=?]", "rank[rank]"

      assert_select "input[name=?]", "rank[experience_point]"
    end
  end
end
