Rails.application.routes.draw do
  root 'schools#index'

  resources :schools

end
