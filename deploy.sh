#!/bin/bash
ssh -t deploy@toronto "cd /srv/meeseeks/ && git pull && bundle install && sudo systemctl restart meeseeks.service"
