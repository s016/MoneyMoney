Rails.application.routes.draw do
  root 'pages#main_page'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
  
  resources :income_and_payments

  resources :items, only: [] do
    resources :detail_items, only: :index
  end
end
