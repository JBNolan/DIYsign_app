Rails.application.routes.draw do
  devise_for :users
  root 'projects#index'
  resources :projects, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :projects do
    resources :steps, only: [:new, :create, :edit, :update, :destroy] do
    end
  end

  resources :projects do
    resources :comments, only: [:new, :create, :edit, :update, :destroy] do
    end
  end

  resources :users, only: [:index, :show, :destroy]

  get '/categories' => 'projects#categories', as: 'categories'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
