Rails.application.routes.draw do
  get "pages/home"
  root "pages#home"

  devise_for :users

  get "stylists/dashboard", to: "stylists#dashboard", as: :stylist_dashboard
  
  delete "stylists/:id/remove_client", to: "stylists#remove_client", as: :remove_client


  resources :recommendations, only: [:edit, :update]

  resources :stylists, only: [] do
    collection do
      post "create_client", to: "stylists#create_client"
    end
  end

 resources :clients, only: [] do
  member do
    get :mane_vault   
  end

  resources :recommendations, only: [:new, :create, :destroy, :index]
end

end
