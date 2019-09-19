Rails.application.routes.draw do
  # namespace :api do
  #   scope :v1 do
  #     mount_devise_token_auth_for 'User', at: 'auth'
  #   end
  # end

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'sendemail', to: 'emails#create'

end
