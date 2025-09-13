Rails.application.routes.draw do
  get "pages/home"
  root "pages#home"

  devise_for :users

  get "stylists/dashboard", to: "stylists#dashboard", as: :stylist_dashboard

  resources :stylists, only: [] do
    collection do
      post "create_client", to: "stylists#create_client"
    end
  end
end
