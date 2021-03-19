Rails.application.routes.draw do
  
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
    end
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
