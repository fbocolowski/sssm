threads 10, 10
environment "production"

bind "unix:/srv/sssm/tmp/puma.sock"
pidfile "/srv/sssm/tmp/puma.pid"
state_path "/srv/sssm/tmp/puma.state"

stdout_redirect "/srv/sssm/log/production.log", "/srv/sssm/log/production.log", true