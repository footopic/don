Rails.application.routes.draw do
  root 'articles#index'

  mount API::Root => '/'

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

  resources :stars, only: [:create, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :uploader, only: [:index, :form, :upload, :download]
end
