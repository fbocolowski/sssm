# SSSM

## Requirements

- MongoDB 3.4
- Ruby 2.5.3 (RVM)
- Rails 5.2.2 or above

## Development

Clone the repository and install dependencies running ```bundle install```.

Start the server running ```rails server```.

Create users:

```
rails console
    User.create(username:  'jhon', password: '123')
```

Go to http://localhost:3000.

## Production

Clone the repository and install dependencies running ```bundle install```.

Start the server creating a systemd service and Nginx server.

Create users:

```
rails console -e production
    User.create(username:  'jhon', password: '123')
```

Go to your Nginx domain.