Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'articles#index'

  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end

    get 'lock'
    get 'unlock'
  end

  resources :stars, only: [:create, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :uploader, only: [:index, :form, :upload, :download]
  resources :users, only: [:index]
  resources :users, path: '/', only: [:edit, :show, :update]
end
