Rails.application.routes.draw do

root to: 'sessions#new'
###
resource :professor, only: [:new, :create, :edit, :update, :show] do
  resources :preferences
  get '/lectures' => 'professors#lectures'
end

resource :session, only: [:new, :create, :destroy]
####

namespace :admin do
  get '/offerings/domagic' => 'offerings#domagic'
  get '/offerings/domagicalltheway' => 'offerings#domagicalltheway'
  get '/offerings/clear' => 'offerings#clear_assignment'
  resources :professors do
    get '/preferences' => 'professors#preferences'
    get '/lectures' => 'professors#lectures'
  end
  resources :offerings do
    put '/resetprof' => 'offerings#resetprof'
  end
  resources :courses do
    get '/preferences' => 'courses#preferences'
    get '/lectures' => 'courses#lectures'
  end
  resource :preferences, only: [:index] do
    get '/professors' => 'preferences#professors'
    get '/offerings' => 'preferences#offerings'
  end
  get '/' => 'dashboard#index'
  post '/semester' => 'dashboard#semester'
  post '/notify_all' => 'dashboard#notify_all'


end

resources :lectures



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
