#!/bin/bash 

[ "$UID" = 0 ] || { echo 'Run this script with sudo'; exit 1; }

useradd -m autossh -p 161TayiCCAPXE

echo "Run the script on the target then run the following to remove the temporary password from this machine:"
echo "sudo passwd -d autossh"