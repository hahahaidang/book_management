Rails.application.routes.draw do


#test
  get 'test/test_page' => 'test#test_page'
  get 'test/ajax' => 'test#ajax'
  get 'test/list_book' => 'test#list_book'

#welcome
  root 'welcome#index'
  match 'welcome/index', via: [:get,:post], controller: :welcome, action: :index, as: 'index_page'
  match 'welcome/search_result', via: [:get], controller: :welcome, action: :search_result, as: 'search_result_page'
  match 'welcome/review_request', via: [:post], controller: :welcome, action: :review_request, as: 'review_request'
  match 'welcome/suggest_form', via: [:post], controller: :welcome, action: :suggest_form, as: 'suggest_form'
  match 'welcome/create_request', via: [:post], controller: :welcome, action: :create_request, as: 'create_request'
  match 'welcome/like', via: [:post], controller: :welcome, action: :like
  match 'welcome/detail/:id', via: [:get], controller: :welcome, action: :detail, as:'welcome_detail'
  match 'welcome/delete_comment', via: [:post], controller: :welcome, action: :delete_comment
  match 'welcome/post_comment', via: [:post], controller: :welcome, action: :post_comment, as:'new_post_comment'

#login
  match 'login/login_page', via: [:get], controller: :login, action: :login_page, as: 'login_page'
  match 'login/sign_in', via: [:post], controller: :login, action: :sign_in
  match 'login/logout_page', via: [:get], controller: :login, action: :logout_page, as: 'logout_page'

#suggest
  match 'suggest/suggest_page', via: [:get], controller: :suggest, action: :suggest_page, as: 'suggest_page'
  match 'suggest/create_suggestion', via: [:post], controller: :suggest, action: :create_suggestion
  match 'suggest/list_book', via: [:post], controller: :suggest, action: :list_book

#management
  match 'manage_book/approve_page', via: [:get], controller: :manage_book, action: :approve_page, as:'approve_page'
  match 'manage_book/managebook_page', via: [:get], controller: :manage_book, action: :managebook_page, as:'managebook_page'
  match 'manage_book/approve/', via: [:post], controller: :manage_book, action: :approve
  match 'manage_book/deny/', via: [:post], controller: :manage_book, action: :deny
  match 'manage_book/unapprove/:id', via: [:get], controller: :manage_book, action: :unapprove
  match 'manage_book/detail_page/:id', via: [:get], controller: :manage_book, action: :detail_page, as:'detail_page'
  match 'manage_book/management_detail_page/:id', via: [:get], controller: :manage_book, action: :management_detail_page, as:'management_detail_page'
  match 'manage_book/update', via: [:post], controller: :manage_book, action: :update
  match 'manage_book/delete/:id', via: [:get], controller: :manage_book, action: :delete
  match 'manage_book/myrequest_page', via: [:get], controller: :manage_book, action: :myrequest_page, as: 'myrequest_page'
  match 'manage_book/cancel_request/:id', via: [:get], controller: :manage_book, action: :cancel_request
  match 'manage_book/modal_detail', via: [:post], controller: :manage_book, action: :modal_detail

#suggest_list
  match 'suggest_list/suggest_list_page', via: [:get], controller: :suggest_list, action: :suggest_list_page, as: 'suggest_list_page'
  match 'suggest_list/detail_suggest_list_page/:id', via: [:get], controller: :suggest_list, action: :detail_suggest_list_page, as: 'detail_suggest_list_page'








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
