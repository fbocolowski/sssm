# SSSM - Stupid Simple Server Monitor

## Requirements

- MongoDB 3.4
- Ruby 2.5.3 (RVM recommended)
- Rails 5.2.2 or above

## Development

Clone the repository and install dependencies running ```bundle install```.

Start the server running ```rails server```.

Go to http://localhost:3000.

## Production

Clone the repository and install dependencies running ```bundle install```.

Generate a Ruby wrapper:

```
rvm wrapper show bundle
```

Generate a production secret key:

```
rake secret
nano config/secrets.yml
production:
    secret_key_base: '< copy the generated code here >'
```

Setup your Nginx:

```
sudo cp config/nginx.conf /etc/nginx/sites-enabled/sssm
nano /etc/nginx/sites-enabled/sssm
sudo systemctl restart nginx
```

Create and start a systemd service:

```
sudo cp config/systemd.service /etc/systemd/system/sssm.service
sudo systemctl daemon-reload
sudo systemctl enable sssm
sudo systemctl start sssm
```
