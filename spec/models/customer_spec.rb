# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Customer, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "ユーザー登録" do
    expect(FactoryBot.build(:customer)).to be_valid
    #expect(customer.nickname).to eq "tarvo"
  end
  
  it
end
