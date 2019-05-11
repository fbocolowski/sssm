Rails.application.routes.draw do
  root 'home#show'
  resource 'home', controller: 'home', only: [:show]
  resource 'login', controller: 'login', only: [:show, :create]
  resource 'registration', controller: 'registration', only: [:show, :create]
  resource 'password_reset', controller: 'password_reset', only: [:show, :create]

  resource 'runner', controller: 'runner', only: [:show]

  resource 'logout', controller: 'logout', only: [:show]
  resource 'account', controller: 'account', only: [:show, :create]
  resource 'delete_account', controller: 'delete_account', only: [:show, :create]
  resource 'change_password', controller: 'change_password', only: [:update]
  resources 'sessions', controller: 'sessions', only: [:index, :destroy]
  resource 'destroy_active_sessions', controller: 'destroy_active_sessions', only: [:destroy]

  resources 'servers', controller: 'servers', only: [:index, :show, :new, :destroy] do
    resources 'triggers', controller: 'triggers' do
      resource 'test', controller: 'test_trigger', only: [:show]
    end
  end
  resources 'log_watchers', controller: 'log_watchers' do
    resource 'test', controller: 'test_log_watcher', only: [:show]
  end
  resource 'charts', controller: 'charts', only: [:show]
  resources 'notifications', controller: 'notifications', only: [:index]

  namespace 'api' do
    resources 'reports', controller: 'reports', only: [:create]
    resources 'error_logs', controller: 'error_logs', only: [:create]
  end
end
