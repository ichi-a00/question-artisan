require 'rails_helper'

RSpec.describe "admin/ranks/show", type: :view do
  before(:each) do
    @admin_rank = assign(:admin_rank, Admin::Rank.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
