Rails.application.routes.draw do
  resources :tweets do
    get :dashboard, on: :collection
  end

  root to: "tweets#dashboard"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'users/:id', to: 'users#show', as: :show_user

  post 'users/:id', to: 'users#follow', as: :follow_user
end
