Rails.application.routes.draw do
  devise_for :users
  # root to: "bins#index"
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :bins, only:[:index, :show, :new, :create, :destroy]
end
