Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :assignments do
    get "download_score", on: :member
    get "grading_overview", on: :member
    get "see_submissions", on: :collection
    get "submissions_within", on: :member
    get "score_overview", on: :member
    get "per_rubric_overview", on: :member
  end

  resources :student_labs

  resources :student_quizzes

  resources :submissions do 
    get "assignments", on: :collection
  end

  resources :students, :only=>[:new, :create, :edit, :update]
  resources :user_sessions
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  get 'flatuipro_demo/index'

  root "home#index"

  get "lab_overview" => "home#lab_overview"

  get "studio_stat" => "home#studio_stat"

  get "ranking" => "home#ranking"

  get "ranking_with_name" => "home#ranking_with_name"

  get "quiz_overview/:id" => "home#quiz"

  get "staff_progress" => "home#staff_progress"

  get "api/assignment/:id" => "assignments#api_data"

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
