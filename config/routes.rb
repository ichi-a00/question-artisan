Rails.application.routes.draw do

  namespace :customer do
    get 'homes/top'
    get 'homes/ranking'
  end
  namespace :admin do
    get 'homes/top'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    # resources :orders, only: [:show, :update]
    # resources :order_details, only: [:update]
    # resources :customers, only: [:index, :show, :edit, :update]
    # resources :products, except: [:destroy] do
    #   collection do
    #     get 'search'
    #   end
    # end
    # resources :genres, only: [:index, :create, :edit, :update] do
    #   member do
    #     get '/' => 'genres#index'
    #   end
    # end
  end

  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customer/sign_in' => 'customer/sessions#new', as: :new_customer_session
    post 'customer/sign_in' => 'customer/sessions#create', as: :customer_session
    delete 'customer/sign_out' => 'customer/sessions#destroy', as: :destroy_customer_session
    get 'customer/sign_up' => 'customer/registrations#new', as: :new_customer_registration
    post 'customer/sign_up' => 'customer/registrations#create', as: :customer_registration
  end

  scope module: :customer do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    # resources :products, only: [:index, :show] do
    #   collection do
    #     get 'search'
    #   end
    # end
    # resources :cart_products, only: [:index, :create, :update, :destroy] do
    #   collection do
    #     delete 'destroy_all'
    #   end
    # end
    # resources :orders, only: [:new, :create, :index, :show] do
    #   collection do
    #     get 'confirm'
    #     post 'confirm'
    #     get 'thanks'
    #   end
    # end
    # resource :customers, only: [:edit, :update] do
    #   collection do
    #     get 'mypage' => 'customers#show'
    #     get '/' => 'customers#show'
    #     get 'unsubscribe'
    #     patch 'withdraw'
    #   end
    # end
    # resources :deliveries, except: [:new, :show] do
    #   member do
    #     get '/' => 'deliveries#index'
    #   end
    # end
  end

  resources :ranks


end
