Rails.application.routes.draw do
  resources :tweets, only: [:new, :create]
  resources :sessions, only: [:create, :destroy]

  match "/welcome" => "static#welcome", :as => :welcome, via: :get

  match "auth/:provider/callback" => "sessions#create", via: :get
  match "/signout" => "sessions#destroy", :as => :signout, via: :get

  root 'tweets#new'
  match '*path' => redirect('/'), via: :get
end
