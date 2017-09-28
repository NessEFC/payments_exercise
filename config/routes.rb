Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :loans, only: [:index, :show] do
        resources :payments, only: [:index, :create]
      end
    end
  end
end
