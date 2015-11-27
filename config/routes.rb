Rails.application.routes.draw do
  resources :articles
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
  end
end
