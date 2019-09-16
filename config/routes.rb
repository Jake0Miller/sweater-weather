Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/coordinates', to: 'coordinates#show'
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'background#show'
      get '/gifs', to: 'gifs#index'
      post '/users', to: 'users#new'
      post '/sessions', to: 'sessions#new'
      post '/road_trip', to: 'road_trip#new'
    end
  end
end
