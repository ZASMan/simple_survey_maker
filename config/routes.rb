Rails.application.routes.draw do
  root "surveys#index"
  resources :answers
  resources :questions
  resources :surveys
end
