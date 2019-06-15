Rails.application.routes.draw do
  root 'login#show'
  resource 'login', controller: 'login', only: [:show, :create]

  resource 'runner', controller: 'runner', only: [:show]

  resource 'logout', controller: 'logout', only: [:show]
  resource 'change_password', controller: 'change_password', only: [:show, :update]

  resources 'servers', controller: 'servers', only: [:index, :show, :new, :destroy]
  resources 'log_watchers', controller: 'log_watchers'
  resources 'triggers', controller: 'triggers'
  resource 'charts', controller: 'charts', only: [:show]
  resources 'notifications', controller: 'notifications', only: [:index]

  namespace 'api' do
    resources 'reports', controller: 'reports', only: [:create]
    resources 'error_logs', controller: 'error_logs', only: [:create]
  end
end
