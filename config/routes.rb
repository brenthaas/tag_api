Rails.application.routes.draw do
  resources :entities, only: [:create]
  post :tag, to: 'tags#create'
  get '/tags/:entity_type/:entity_id', to: 'tags#show_entity'
  delete '/tags/:entity_type/:entity_id', to: 'tags#delete_entity'
  get '/stats', to: 'tags#stats'
end
