Rails.application.routes.draw do
  root "messages#new"
  resources :messages
  resources :categories
end
