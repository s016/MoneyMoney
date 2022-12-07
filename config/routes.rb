Rails.application.routes.draw do
  root 'pages#main_page'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
  
  resources :income_and_payments, only: [:new, :create] do
    collection do
      get :select_incomes
      get :select_payments 
      get :select_item
      get :incomes
      get :payments
    end
  end

  resources :money_places, only: [:index, :new, :create]
  
  resources :detail_items, only: [:index, :new, :create] do
    collection do
      get :select_incomes
      get :select_payments 
    end
  end

  resources :results, only: [:index] do
    get 'open_item', on: :member
  end
  resources :actual_monies, only: [:new, :create]
end
