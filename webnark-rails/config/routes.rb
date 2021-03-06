WebnarkRails::Application.routes.draw do

  devise_for :users

  resources :answers
  resources :report_choices
  resources :report_items
  resources :report_categories

  root :to => 'high_voltage/pages#show', id: 'home'

  get '/search/:query', to: 'services#search'
  get '/search', to: 'services#search'

  get '/services/:id/full', to: 'services#full', as: :full_report
  post "/services/add_comment" => "services#add_comment", :as => "add_comment_to_services", :via => [:services]
  get '/services/unmoderated', to: 'services#unmoderated', as: :unmoderated_services
  get '/services/flagged', to: 'services#flagged', as: :flagged_services
  get '/services/:id/report', to: 'services#report', as: :report_service
  get '/services/:id/moderate', to: 'services#moderate', as: :moderate_service
  get '/services/:id/unreport', to: 'services#unreport', as: :unreport_service
  get '/services/tagged' => 'services#tagged', :as => 'tagged'
  resources :services

  get '/comments/:id/report', to: 'comments#report', as: :report_comment
  get '/comments/flagged', to: 'comments#flagged', as: :flagged_comments
  resources :comments

  get '/pages/about', to: 'high_voltage/pages#show', id: 'about'

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
