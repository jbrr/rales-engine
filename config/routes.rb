Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, except: [:new, :edit], defaults: { format: :json }
      resources :merchants, except: [:new, :edit], defaults: { format: :json }
      resources :invoices, except: [:new, :edit], defaults: { format: :json }
    end
  end
end
