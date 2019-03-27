#!/bin/bash
ssh -t deploy@toronto "cd /srv/sssm/ && git pull && bundle install && sudo systemctl restart sssm.service"
