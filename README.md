# autossh-reverse-tunnel
I've set this up a few times from scratch so I figured I would automate the process and share. This is a set of shell scripts to make a linux server accessible when it is behind a firewall and/or NAT device without opening inbound network access. It uses the ssh remote port forwarding feature to open a port on a bastion server that forwards back to sshd on the target machine. It also uses autossh to make the connection persistent and upstart to start autossh at boot.

## Requirements
This setup requires ssh network connectivity outbound from the target machine to the bastion server. 

This has been tested on Ubuntu 12.04 and 14.04. Use at your own risk!

### Setup 
Open a new terminal session on the __bastion__ machine. Execute the following command.
```
curl -s https://raw.githubusercontent.com/billmoritz/autossh-reverse-tunnel/master/bastion.sh | sudo bash 
```

Open a new terminal session on the __target__ machine. Replace the bastion.example.com hostname in the following command and execute it. 
```
curl -s https://raw.githubusercontent.com/billmoritz/autossh-reverse-tunnel/master/target.sh | sudo bash -s bastion.example.com
```

__Go back the bastion terminal and delete the temporate password by running:__ ```sudo passwd -d autossh```

### Connection
To ssh to the target from the bastion ssh to localhost on port 10022.
```
ssh localhost -p 10022
```