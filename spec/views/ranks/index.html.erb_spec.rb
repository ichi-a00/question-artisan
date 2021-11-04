require 'rails_helper'

RSpec.describe "ranks/index", type: :view do
  before(:each) do
    assign(:ranks, [
      Rank.create!(
        rank: 2,
        experience_point: 3
      ),
      Rank.create!(
        rank: 2,
        experience_point: 3
      )
    ])
  end

  it "renders a list of ranks" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
