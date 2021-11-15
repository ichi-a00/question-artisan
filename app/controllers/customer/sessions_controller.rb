# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :check_customer_status, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # 退会ステータスを確認
  def check_customer_status
    @customer = Customer.find_by(nickname: params[:customer][:nickname])
    return if !@customer
    if (@customer.valid_password?(params[:customer][:password])) && (@customer.is_valid == false)
      flash[:alert] = "このアカウントは退会済みです。"
      redirect_to new_customer_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
