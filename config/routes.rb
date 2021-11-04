Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customer/sessions#new', as: :new_customer_session
    post 'customers/sign_in' => 'customer/sessions#create', as: :customer_session
    delete 'customers/sign_out' => 'customer/sessions#destroy', as: :destroy_customer_session
    get 'customers/sign_up' => 'customer/registrations#new', as: :new_customer_registration
    post 'customers/sign_up' => 'customer/registrations#create', as: :customer_registration
  end

  resources :ranks
end
