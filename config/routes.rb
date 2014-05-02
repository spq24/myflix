Myflix::Application.routes.draw do


  root to: "static_pages#front"
	require 'sidekiq/web'
	mount Sidekiq::Web => '/sidekiq'


	  	resources :videos do
	  		collection do
	  			post :search, to: "videos#search"
	  		end
	  		resources :reviews
	  	end

	  	namespace :admin do
	  		resources :videos, only: [:new, :create]
	  		resources :payments, only: [:index]
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
  		resources :invitations, only: [:new, :create]


	  	get '/register', 					to: "users#new"
	  	get 'register/:token',				to: "users#new_with_invitation_token", as: 'register_with_token'
	  	get '/sign_in', 					to: "sessions#new"
	  	get '/sign_out', 					to: "sessions#destroy"
	  	get '/home', 						to: "videos#index"
	  	get '/my_queue', 					to: "queue_items#index"
	  	get '/forgot_password',				to: "forgot_passwords#new"
	  	get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
	  	get 'expired_token', 				to: "pages#expired_token"

	  	
	  	mount StripeEvent::Engine => '/stripe_events'

  		get 'ui(/:action)', controller: 'ui'


end
