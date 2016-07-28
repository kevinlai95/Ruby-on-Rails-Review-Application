Rails.application.routes.draw do
  get 'sessions/new'

  resources :restaurants do
    resources :reviews
  end
  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 		'restaurants#index'
  get   	'signup'    =>  'users#new'
  get		'login'		=>	'sessions#new'
  post		'login'		=>	'sessions#create'
  delete	'logout'	=>	'sessions#destroy'
  get 'reviews' => 'reviews#show'
end
