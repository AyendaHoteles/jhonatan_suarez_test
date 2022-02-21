Rails.application.routes.draw do
  get '/', to:'general#all'
  # resources :tests
  resource :api do
    resource :v1 do
      get '/', to:'general#all'
      get 'artists', to: 'general#artirts'
      get 'artists/:id/albums', to: 'general#albums'  
      get 'albums/:id/songs', to: 'general#songs'  
      get 'genres/:genre_name/random_song', to: 'general#genres'  
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
