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
  		resources :users, only: [:show]
  		get 'people', to: 'relationships#index'
  		resources :relationships, only: [:destroy]
  		resources :sessions, only: [:create]


	  	get '/register', 	to: "users#new"
	  	get '/sign_in', 	to: "sessions#new"
	  	get '/sign_out', 	to: "sessions#destroy"
	  	get '/home', 		to: "videos#index"
	  	get '/my_queue', 	to: "queue_items#index"
  		get 'ui(/:action)', controller: 'ui'


end
