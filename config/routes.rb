Rails.application.routes.draw do
  resources :campaigns, only: [:new, :create, :show, :edit, :destroy]
  root 'campaigns#new'
end
