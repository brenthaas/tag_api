Rails.application.routes.draw do
  resources :entities, only: [:create]
end
