class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email])
    devise_parameter_sanitizer.permit(:account_update,
    keys: [
      :nickname,
      :email,
      :image,
      :introduction,
      :rank,
      :experience_point,
      :is_valid,
    ])
  end
end
