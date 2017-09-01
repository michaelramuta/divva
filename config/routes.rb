Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  resources :rides do
  end

  resources :stations do
  end

  resources :trips do
  end

end
