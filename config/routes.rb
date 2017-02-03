Rails.application.routes.draw do
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

  get '/categories' => 'projects#categories', as: 'categories'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
