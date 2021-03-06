IdeaMachine::Application.routes.draw do
  root "auths#new"

  resources :users, only: [:show]
  resources :ideas, only: [:create, :destroy, :edit, :update]

  match '/signup', to: 'users#new', via: 'get'
  match '/signup', to: 'users#create', :via => 'post'
  match '/signin', to: 'auths#new', via: 'get'
  match '/signin', to: 'auths#create', via: 'post'
  match '/signout', to: 'auths#destroy', via: 'delete'

  match '/feedback', to: "static_pages#feedback", via: 'get'
  match '/send_feedback', to: "static_pages#send_feedback", via: 'post'
  match '/about', to: "static_pages#about", via: 'get'
  
  match '/forgot_password', to: "auths#forgot_password", via: 'get'
  match '/forgot_password', to: "auths#password_reset_token", via: 'post'
  match '/reset_password', to: "auths#reset_password", via: 'get'
  match '/reset_password', to: "users#update_password", via: 'post'

  post '/ideas/:id/favorite', to: "ideas#favorite", as: :favorite
  post '/ideas/:id/unfavorite', to: "ideas#unfavorite", as: :unfavorite
 

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/meerkat'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
