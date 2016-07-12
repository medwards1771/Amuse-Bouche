Rails.application.routes.draw do
  resources :searches, only: [:show, :new, :create]
  root 'searches#new'
end
