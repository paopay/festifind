Rails.application.routes.draw do
  get 'festivals/playlists', :to => 'festivals#playlists'
  get 'festivals/login', :to => 'festivals#login'
  get 'festivals/auth', :to => 'festivals#auth'
  resources :festivals, :only => [:index]
  root :to => "festivals#index"
end
