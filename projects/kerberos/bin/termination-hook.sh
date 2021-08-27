#!/bin/bash
# set up termination scripts for cluster
# note - runs as hadoop; sudo if needed
sudo mkdir -p /mnt/var/lib/instance-controller/public/shutdown-actions
sudo aws s3 cp s3://hugh-fido-lab/bin/dns-unreg.sh /mnt/var/lib/instance-controller/public/shutdown-actions/
