#!/bin/bash 

[ "$UID" = 0 ] || { echo 'Run this script with sudo'; exit 1; }
[ "$1" = '' ] && { echo 'Run this script with the hostname of the middle server as a parameter'; exit 1; }

which autossh > /dev/null || apt-get install -y --no-install-recommends autossh
which sshpass > /dev/null || apt-get install -y --no-install-recommends sshpass

useradd -m autossh

su -c "ssh-keygen -q -f ~/.ssh/id_rsa -N ''" autossh
su -c "ssh-keyscan -t rsa $1 >> ~autossh/.ssh/known_hosts" autossh
su -c "sshpass -p EiCh8ooX ssh-copy-id $1" autossh

echo "description \"autossh tunnel\"
  
    start on (local-filesystems and net-device-up IFACE=eth0) 
    stop on runlevel [016]
    setuid autossh
  
    respawn
    respawn limit 5 60
  
    exec /usr/bin/autossh -M 0 -N -q -o \"PubkeyAuthentication=yes\" -o \"PasswordAuthentication=no\" -o \"ServerAliveInterval 60\" -o \"ServerAliveCountMax 3\" -p 22 -l autossh $1 -R 10022:localhost:22 -i /home/autossh/.ssh/id_rsa
" > /etc/init/autossh.conf

start autossh

echo "Go back the bastion terminal and delete the temporate password!"