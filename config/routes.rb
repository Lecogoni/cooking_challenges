Rails.application.routes.draw do
  
  resources :recipes
  resources :questions
  resources :surveys
  resources :guests
  resources :welcome
  resources :events
  resources :challenges

  devise_for :users
  resources :users

  
  root 'welcome#index'

  resources :events do
    member do
      post :toggle_participation
      post :toggle_status
      post :abort_status
    end
  end

  resources :challenges do
    member do
      get :upd
      post :upd
      put :upd
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
