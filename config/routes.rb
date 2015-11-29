Rails.application.routes.draw do
  root 'home#index'

  get 'uploader/index'
  get 'uploader/form'
  post 'uploader/upload'
  get 'uploader/download'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  resources :users, only: [:index, :edit, :show, :update]
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
  end

  resources :comments, only: [:create, :update, :destroy]
end
