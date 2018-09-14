Rails.application.routes.draw do
  resources :content_filters
  root "answers#index"
  resources :answers
  resources :questions
  resources :surveys
end
