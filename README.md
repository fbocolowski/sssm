# Meeseeks

## Requisitos

- MongoDB v3.4
- Ruby 2.5.3
- Rails 5.2.2 ou superior
- NGINX (produção)

## Uso
sudo su
crontab -e
* * * * * curl -s https://meeseeks.ml/runner.sh | bash -s [token do servidor]

## Desenvolvimento

Clone o repositório, vá até a pasta do projeto e instale as dependências executando ```bundle install```.

Inicie o servidor com ```rails server```.

Acesse http://localhost:3000.

## Produção

Clone o repositório na pasta /srv/, vá até a pasta do projeto e instale as dependências executando ```bundle install```.

Configure o NGINX:

```text
sudo nano /etc/nginx/sites-enabled/meeseeks
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
sudo systemctl restart nginx
```

Configure o systemd:

```text
rvm wrapper show bundle
sudo nano /etc/systemd/system/meeseeks.service
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
sudo systemctl daemon-reload
sudo systemctl enable meeseeks
sudo systemctl start meeseeks
```

Acesse o domínio registrado no NGINX.
