Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :campaigns, only: [:new, :create, :show, :edit, :destroy] do
    resources :publishings, only: :create
  end

  resources :nearby_campaigns, only: :index

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root 'welcome#index'
end
