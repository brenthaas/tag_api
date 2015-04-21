Rails.application.routes.draw do
  resources :entities, only: [:create]
  post :tag, to: 'tags#create'
end
