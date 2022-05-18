Rails.application.routes.draw do
  root "pages#home"
  devise_for :users,:controllers=>{
    registrations: "users/registrations",
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
 
  get "/article", to: "article#index" 
  get "admin_new_user", to: "admin#new"
  get "admin_edit/:id", to:"admin#edit"
  post "admin_create", to:"admin#create"
  post "admin_update/:id", to:"admin#update"
  get "user_search_result", to: "users#search_result"
end
