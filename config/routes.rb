Rails.application.routes.draw do
  resources :festivals, :only => [:index]
  root :to => "festivals#index"
end
