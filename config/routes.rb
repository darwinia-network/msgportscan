Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'messages#index'
  resources :messages, only: %i[index]
  # make better routes

  get 'message' => 'messages#message', as: :message
  get 'messages/:tx_or_hash' => 'messages#show',
      as: :message_by_tx_or_hash,
      constraints: { tx_or_hash: /0x[0-9a-fA-F]{64}/ }
  get 'messages/:from_network(/:to_network)' => 'messages#index', as: :network_messages
end
