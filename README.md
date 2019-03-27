# SSSM - Stupid Simple Server Monitor

## Requirements

- MongoDB v3.4
- Ruby 2.5.3
- Rails 5.2.2 or above
- NGINX (production)

## Uso

```bash
sudo su
crontab -e
```

```text
* * * * * curl -s https://meeseeks.ml/runner.sh | bash -s [server token]
```

## Development

Clone the repository and nstall dependencies running ```bundle install```.

Start the server running ```rails server```.

Go to http://localhost:3000.

## Production

Clone the repository at /srv/ and install dependencies running ```bundle install```.

Setup NGINX:

```bash
sudo nano /etc/nginx/sites-enabled/meeseeks
sudo nano /etc/nginx/conf.d/meeseeks.conf
```

```text
server {
	listen 80;
	server_name meeseeks.ml;

	root /srv/meeseeks/public/;
	try_files $uri @puma;

	location @puma {
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $host;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_redirect off;
		proxy_pass http://unix:/srv/meeseeks/tmp/puma.sock;
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
sudo nano /etc/systemd/system/meeseeks.service
```

```text
[Unit]
After=network.target

[Service]
Type=forking
User=deploy
WorkingDirectory=/srv/meeseeks/
ExecStart=/home/deploy/.rvm/gems/ruby-2.5.3/wrappers/bundle exec puma -C config/puma_production.rb --daemon
ExecStop=/home/deploy/.rvm/gems/ruby-2.5.3/wrappers/bundle exec pumactl -S tmp/puma.state stop
PIDFile=/srv/meeseeks/tmp/puma.pid
Restart=always

[Install]
WantedBy=multi-user.target
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable meeseeks
sudo systemctl start meeseeks
```

Go to your NGINX domain.