Rails.application.routes.draw do
  resources :entities, only: [:create]
  post :tag, to: 'tags#create'
  get '/tags/:entity_type/:entity_id', to: 'tags#show_entity'
end
