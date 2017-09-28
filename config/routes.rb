Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :loans, only: [:index, :show] do
        resources :payments, only: [:index, :create], controller: 'loans/payments'
      end

      resources :payments, only: [:show]
    end
  end
end
