Rails.application.routes.draw do
  root 'pages#main_page'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
end
