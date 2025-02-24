#!/bin/bash
# Load NVMe TCP module
modprobe nvme-tcp

# Discover NVMe targets
nvme discover -t tcp -a 192.168.10.21 -s 4420

# Connect to the target
nvme connect -t tcp -n "nqn.2024-01.com.example:st01" -a 192.168.10.21 -s 4420

# Verify connection
nvme list

echo "NVMe-oF Initiator setup complete on sv03"
