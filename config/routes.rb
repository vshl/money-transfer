Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/transfer' => 'transfer#send_money'
  resources :users
  resources :accounts
end
