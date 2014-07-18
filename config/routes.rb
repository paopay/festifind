Rails.application.routes.draw do
  get 'admin/playlists', :to => 'admin#playlists'
  get 'admin/generate', :to => 'admin#generate'
  get 'admin/auth', :to => 'admin#auth'
  get 'festivals/sort', :to => 'festivals#sort'
  get 'festivals/videos', :to => 'festivals#videos'
  get 'artists/find', :to => 'artists#find'
  get 'artists/search', :to => 'artists#search'
  get 'festivals/angular/', :to => 'festivals#angular'
  post 'users/create', :to => 'users#create'
  resources :festivals, :only => [:index,:show]
  root :to => "festivals#index"
end
