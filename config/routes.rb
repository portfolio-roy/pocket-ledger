Rails.application.routes.draw do
  resources :categories do 
    resources :items
  end
  devise_for :users
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end  
  root to: 'home#index'
end
