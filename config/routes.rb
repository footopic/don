Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  resources :articles
  resources :user
  root 'home#index'
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :users, :only => [:index, :show]
end
