Rails.application.routes.draw do
  get 'admin/playlists', :to => 'admin#playlists'
  get 'admin/generate', :to => 'admin#generate'
  get 'admin/auth', :to => 'admin#auth'
  get 'festivals/sort', :to => 'festivals#sort'
  get 'artists/find', :to => 'artists#find'
  resources :festivals, :only => [:index,:show]
  root :to => "festivals#index"
end
