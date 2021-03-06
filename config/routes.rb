Rails.application.routes.draw do
  root 'backbone#index'

  namespace :api, defaults: {format: :json} do

    get 'stream', to: 'streams#index'
    get 'favorites', to: 'likes#index'

    resources :tags, only: :index
    get 'tags/:name', to: 'tags#show'

    resources :users do
      resources :playlists, only: :index
      resource :follow, only: [:create, :destroy]
    end

    resources :tracks do
      resources :comments, only: [:new, :create, :index]
      resource :like, only: [:create, :destroy]
      member do
        post 'tag' => 'tags#add'
        delete 'tag' => 'tags#remove'
      end
    end

    resources :playlists, except: :index
    resources :playlists do
      member do
        post 'add_track/:track_id' => 'playlists#add_track'
        post 'remove_track/:track_id' => 'playlists#remove_track' # TODO MAKE THIS RESTFUL
      end
    end

    resources :comments, only: [:edit, :update, :destroy]

  end

  get 'backbone', to: 'backbone#index'

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
#   resources :tracks do
#     member do
#       get 'like'
#       get 'unlike'
#     end
#     resources :comments, only: [:new, :create, :index]
#   end
#   resource :profile, only: [:edit, :update]
#   resources :liked_tracks, only: :index
#   resources :users do
#     resources :playlists, only: :index
#   end
#
#   resources :comments, only: [:edit, :update, :destroy]
#
#   resources :playlist_memberships, only: [:create, :destroy]
#   resources :playlists, except: :index
end
