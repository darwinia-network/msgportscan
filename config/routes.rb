Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'messages#index'
  resources :messages, only: %i[index]
  get 'messages/:from_network(/:to_network)' => 'messages#index', as: :network_messages
  get 'messages/:from_network/:to_network/:index' => 'messages#show', as: :network_message
end
