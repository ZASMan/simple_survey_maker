Rails.application.routes.draw do
  resources :content_filters
  root "surveys#index"
  resources :answers
  resources :questions
  resources :surveys
end
