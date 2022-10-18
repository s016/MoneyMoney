Rails.application.routes.draw do
  root 'pages#main_page'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
  
  resources :income_and_payments, only: [:new, :create] do
    collection do 
      get :select_item
      get :incomes
      get :payments
    end
  end

  resources :money_places, only: [:index, :new, :create]
  resources :detail_items, only: [:index, :new, :create]
end
