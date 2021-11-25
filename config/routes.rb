Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    #管理者ログイン
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'

    resources :customers, except: [:new, :create, :destroy]
    resources :questions do
      collection do
        post 'import'
      end
      member do
        resources :answers, only: [:edit, :create, :update, :destroy]
      end
    end
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

    resources :customers, only: [:edit, :update, :show, :index] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
      resource :follows, only: [:create, :destroy] do
        get 'followings'
        get 'followers'
      end
    end

    resources :questions do
      collection do
        get "answer_format" => 'questions#answer_format', as: :answer_format
        get 'get_tag_search', defaults: { format: 'json' }
        get "alltags"
      end
      member do
        get "artisan" => 'questions#artisan', as: :artisan
        post "result" => 'questions#result', as: :result
        get 'get_tag_search', defaults: { format: 'json' }
      end
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  resources :ranks

end
