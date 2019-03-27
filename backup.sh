#!/bin/bash
ssh -t deploy@toronto "mongodump --gzip --db sssm --archive=sssm-db.gz"
scp deploy@toronto:sssm-db.gz /tmp/
mongo sssm-dev --eval "db.dropDatabase()"
mongorestore --gzip --archive=/tmp/sssm-db.gz --nsFrom "sssm.*" --nsTo "sssm-dev.*"
rm -fr /tmp/sssm-db.gz