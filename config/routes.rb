Rails.application.routes.draw do
  get 'festivals/playlists', :to => 'festivals#playlists'
  get 'festivals/generate', :to => 'festivals#generate'
  get 'festivals/auth', :to => 'festivals#auth'
  get 'festivals/sort', :to => 'festivals#sort'
  get 'artists/find', :to => 'artists#find'
  resources :festivals, :only => [:index,:show]
  root :to => "festivals#index"
end
