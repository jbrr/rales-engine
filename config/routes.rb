Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer, except: [:new, :edit], defaults: { format: :json }
      resources :merchant, except: [:new, :edit], defaults: { format: :json }
      resources :invoice, except: [:new, :edit], defaults: { format: :json }
    end
  end
end
