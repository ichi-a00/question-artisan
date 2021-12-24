class Customer::FollowsController < ApplicationController
  before_action :set_customer!
  before_action :authenticate_customer!, only: [:create, :destroy]

  # フォローする人：current_customer.id, フォローされる人：params[:customer_id]
  def create
    follow = Follow.new(following_id: current_customer.id, followed_id: @customer.id)
    follow.save
    # artisanのresult画面から来たときだけ非同期
    unless URI(request.referer.to_s).path.include?("/artisan")
      redirect_back(fallback_location: root_path)
    end
  end

  def followings
  end

  def followers
  end

  def destroy
    follow = current_customer.following.find_by(followed_id: @customer.id)
    follow.destroy!
    unless URI(request.referer.to_s).path.include?("/artisan")
      redirect_back(fallback_location: root_path)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer!
    @customer = Customer.find(params[:customer_id])
  end
end
