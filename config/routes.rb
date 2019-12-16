Rails.application.routes.draw do
  resources :posts, only: :create do
    get :top, on: :collection
  end

  resources :ratings, only: :create
  scope module: :users do
    get 'co_authors'
  end
end
