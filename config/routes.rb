Todo::Application.routes.draw do
  devise_for :users

  resources :lists do
    resources :tasks
  end

  root :to => "lists#index"
end
