Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'welcome/home', to: 'welcome#home'
  #get 'welcome/about', to: 'welcome#about'

  root 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :articles
  resources :categories

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
