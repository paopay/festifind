Rails.application.routes.draw do
  get 'festivals/playlists', :to => 'festivals#playlists'
  get 'festivals/login', :to => 'festivals#login'
  get 'festivals/auth', :to => 'festivals#auth'
  get 'artists/find', :to => 'artists#find'
  resources :festivals, :only => [:index, :show]
  root :to => "festivals#index"
end
