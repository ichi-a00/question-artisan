# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Customer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it "姓、名を登録すると、姓名が取得できること" do
    customer = Customer.new(
        nickname: "taro",
        email: "taro@test.com",
        password: "tarotaro"
    )
    expect(customer.nickname).to eq "taro"
  end
end
