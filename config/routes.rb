Rails.application.routes.draw do
  root 'pages#main_page'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
  
  resources :income_and_payments do
    collection do 
      get :select_item
    end
  end

  resources :detail_items, only: :index
end
