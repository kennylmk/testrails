Rails.application.routes.draw do
  # root "scores#index"
    get 'scores/history', to: 'scores#history'
    get 'scores/list', to: 'scores#list'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :scores
end
