Rails.application.routes.draw do
  root 'home#show'
  resource 'home', controller: 'home', only: [:show]
  resource 'login', controller: 'login', only: [:show, :create]
  resource 'registration', controller: 'registration', only: [:show, :create]

  resource 'logout', controller: 'logout', only: [:show]
  resource 'account', controller: 'account', only: [:show, :create]
  resource 'change_password', controller: 'change_password', only: [:update]
  resources 'sessions', controller: 'sessions', only: [:index, :destroy]

  resources 'servers', controller: 'servers', only: [:index, :show, :new, :destroy]
  resource 'charts', controller: 'charts', only: [:show]

  namespace 'api' do
    resources 'reports', controller: 'reports'
  end
end
