Myflix::Application.routes.draw do


  root to: "static_pages#front"



	  	resources :videos do
	  		collection do
	  			post :search, to: "videos#search"
	  		end
	  		resources :reviews
	  	end

	  	resources :categories, only: [:show]
	  	resources :queue_items, only: [:create, :destroy]
	  	post 'update_queue', to: 'queue_items#update_queue'
  		resources :users
  		get 'people', to: 'relationships#index'
  		resources :relationships, only: [:create, :destroy]
  		resources :sessions, only: [:create]
  		resources :forgot_passwords, only: [:create]
  		resources :password_resets, only: [:show, :create]


	  	get '/register', 					to: "users#new"
	  	get '/sign_in', 					to: "sessions#new"
	  	get '/sign_out', 					to: "sessions#destroy"
	  	get '/home', 						to: "videos#index"
	  	get '/my_queue', 					to: "queue_items#index"
	  	get '/forgot_password',				to: "forgot_passwords#new"
	  	get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
	  	get 'expired_token', 				to: "password_resets#expired_token"
	  	


  		get 'ui(/:action)', controller: 'ui'


end
