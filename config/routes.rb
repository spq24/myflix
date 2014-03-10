Myflix::Application.routes.draw do


  root to: "static_pages#front"


	  	resources :videos do
	  		collection do
	  			post :search, to: "videos#search"
	  		end
	  	end

	  	resources :categories
  		resources :users
  		resources :sessions, only: [:create]

	  	get 'register', to: "users#new"
	  	get 'sign_in', to: "sessions#new"
	  	get 'sign_out', to: "sessions#destroy"
	  	get 'home', to: "videos#index"
  		get 'ui(/:action)', controller: 'ui'


end
