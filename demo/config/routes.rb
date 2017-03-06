Rails.application.routes.draw do



#index
  root 'welcome#index'
  get 'welcome/index' => 'welcome/index'
  get 'welcome/search_result' => 'welcome#search_result'
#login
  get 'login/login_page' => 'login#login_page'
  post 'login/sign_in' => 'login#sign_in'
  get 'login/logout_page' => 'login#logout_page'
  get 'login/login_fail' => 'login#login_fail'
#suggest
  get 'suggest/suggest_page' => 'suggest#suggest_page'
  post 'suggest/create_suggestion' => 'suggest#create_suggestion'
#management
  get 'manage_book/approve_page' => 'manage_book#approve_page'
  get 'manage_book/managebook_page' => 'manage_book#managebook_page'
  get 'manage_book/approve/:id' =>  'manage_book#approve'
  get 'manage_book/deny/:id' =>  'manage_book#deny'
  get 'manage_book/unapprove/:id' =>  'manage_book#unapprove'
  get 'manage_book/detail_page/:id' => 'manage_book#detail_page'
  get '/manage_book/management_detail_page/:id' => 'manage_book#management_detail_page'
  post '/manage_book/update' => 'manage_book#update'
  get '/manage_book/delete/:id' => 'manage_book#delete'

#suggest_list
  get 'suggest_list/suggest_list_page' => 'suggest_list/suggest_list_page'
  get 'suggest_list/detail_suggest_list_page/:id' => 'suggest_list#detail_suggest_list_page'







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
