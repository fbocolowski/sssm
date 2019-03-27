Rails.application.routes.draw do
  root 'login#show'
  resource 'login', controller: 'login', only: [:show, :create]
  resource 'logout', controller: 'logout', only: [:show]
  resource 'registration', controller: 'registration', only: [:show, :create]

  resources 'servers', controller: 'servers'

  namespace 'api' do
    resources 'reports', controller: 'reports'
  end
end
