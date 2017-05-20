Rails.application.routes.draw do
  resources :organisations
  root 'welcome#index'
  get 'welcome/index'

  devise_for :users, controllers: { registrations: "registrations" }
end
