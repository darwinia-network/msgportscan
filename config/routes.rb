Rails.application.routes.draw do
  root 'messages#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :messages, only: %i[index show]
  get 'messages/:network/:index' => 'messages#show', as: :network_message
end
