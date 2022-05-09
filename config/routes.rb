Rails.application.routes.draw do
  devise_for :users,:controllers=>{
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :password => "users/passwords",
    :confirmations => "users/confirmations"
  }

  resources :comments

  resources :articles


  resources :users do
    resources :articles
  end

  resources :articles do 
    resources :comments 
  end
  root "pages#home"
  get "/article", to: "article#index" 
  get "admin_new_user", to: "admin#new"
  get "admin_edit/:id", to:"admin#edit"
  post "admin_create", to:"admin#create"
  post "admin_update", to:"admin#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
