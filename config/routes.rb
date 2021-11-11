Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    #管理者ログイン
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'

    resources :customers, except: [:new, :create, :destroy]
    resources :questions do
      member do
        resources :answers, only: [:edit, :create, :update, :destroy]
      end
    end
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
    #ログイン・ログアウト(devise)
    get 'customer/sign_in' => 'customer/sessions#new', as: :new_customer_session
    post 'customer/sign_in' => 'customer/sessions#create', as: :customer_session
    delete 'customer/sign_out' => 'customer/sessions#destroy', as: :destroy_customer_session

    #新規登録(devise)
    get 'customer/sign_up' => 'customer/registrations#new', as: :new_customer_registration
    post 'customer/sign_up' => 'customer/registrations#create', as: :customer_registration

    #パスワード変更(devise)
    get 'customers/edit/password' => 'customer/registrations#edit', as: :edit_customer_registration
    put 'customer/sign_up' => 'customer/registrations#update'
  end

  scope module: :customer do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resource :customers, only: [:edit, :update] do
      collection do
        get 'mypage' => 'customers#show'
        get '/' => 'customers#show'
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :questions

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
