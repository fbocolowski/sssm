threads 5, 5
environment "production"

bind "unix:/srv/meeseeks/tmp/puma.sock"
pidfile "/srv/meeseeks/tmp/puma.pid"
state_path "/srv/meeseeks/tmp/puma.state"

stdout_redirect "/srv/meeseeks/log/puma.log", "/srv/meeseeks/log/puma.log", true