# SSSM - Stupid Simple Server Monitor

## Requirements

- MongoDB v3.4
- Ruby 2.5.3
- Rails 5.2.2 or above
- NGINX (production)

## Development

Clone the repository and install dependencies running ```bundle install```.

Start the server running ```rails server```.

Go to http://localhost:3000.

## Production

Clone the repository at /srv/ and install dependencies running ```bundle install```.

Generate a Rails Secret running ```rake secret```.

```bash
nano config/secrets.yml
```

```text
production:
  secret_key_base: '[RAILS_SECRET_KEY]'
```

Setup NGINX:

```bash
# Debian
sudo nano /etc/nginx/sites-enabled/sssm
# Red Hat
sudo nano /etc/nginx/conf.d/sssm.conf
```

```text
server {
	listen 80;
	server_name sssm.ml;

	root /srv/sssm/public/;
	try_files $uri @puma;

	location @puma {
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $host;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_redirect off;
		proxy_pass http://unix:/srv/sssm/tmp/puma.sock;
	}

	keepalive_timeout 10;
}
```

```bash
sudo systemctl restart nginx
```

Setup systemd:

```bash
rvm wrapper show bundle
sudo nano /etc/systemd/system/sssm.service
```

```text
[Unit]
After=network.target

[Service]
Type=forking
User=deploy
WorkingDirectory=/srv/sssm/
ExecStart=/home/deploy/.rvm/gems/ruby-2.5.3/wrappers/bundle exec puma -C config/puma_production.rb --daemon
ExecStop=/home/deploy/.rvm/gems/ruby-2.5.3/wrappers/bundle exec pumactl -S tmp/puma.state stop
PIDFile=/srv/sssm/tmp/puma.pid
Restart=always

[Install]
WantedBy=multi-user.target
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable sssm
sudo systemctl start sssm
```

Go to your NGINX domain.