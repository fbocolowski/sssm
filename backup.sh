#!/bin/bash
ssh -t deploy@toronto "mongodump --gzip --db meeseeks --archive=meeseeks-db.gz"
scp deploy@toronto:meeseeks-db.gz /tmp/
mongo meeseeks-dev --eval "db.dropDatabase()"
mongorestore --gzip --archive=/tmp/meeseeks-db.gz --nsFrom "meeseeks.*" --nsTo "meeseeks-dev.*"
rm -fr /tmp/meeseeks-db.gz