Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check
 
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1  do
      resources :addresses, only: %i[create update  destroy]
      resources :categories, only: %i[index show]
      resources :properties, only: %i[index show create update  destroy]
      resources :reservations, only: %i[index show create update  destroy]
      resources :reservation_criterias, only: %i[index show create update  destroy]
      resources :user, only: %i[show index update destroy]
      post 'auth/sign_in' ,to: 'authentication#sign_in'
      post 'auth/sign_up', to: 'authentication#sign_up'
    end
  end
  
end
