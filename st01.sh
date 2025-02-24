#!/bin/bash
# Load required modules
modprobe nvmet
modprobe nvmet-tcp

# Create NVMe subsystem
mkdir /sys/kernel/config/nvmet/subsystems/nqn.2024-01.com.example:st01
cd /sys/kernel/config/nvmet/subsystems/nqn.2024-01.com.example:st01

# Allow any host to connect
echo 1 > attr_allow_any_host

# Create namespace (replace /dev/nvme0n1 with your actual block device)
mkdir namespaces/10
cd namespaces/10
echo -n /dev/nvme0n1 > device_path
echo 1 > enable

# Create TCP port
mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1

# Set IP address to the interface facing the client (ens786f1)
echo 192.168.10.21 > addr_traddr
echo tcp > addr_trtype
echo 4420 > addr_trsvcid
echo ipv4 > addr_adrfam

# Link subsystem to port
ln -s /sys/kernel/config/nvmet/subsystems/nqn.2024-01.com.example:st01 /sys/kernel/config/nvmet/ports/1/subsystems/

# Enable firewall port
firewall-cmd --add-port=4420/tcp --permanent
firewall-cmd --reload

echo "NVMe-oF Target setup complete on st01"
