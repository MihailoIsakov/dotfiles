#! /bin/bash 

# USER="user"
# HOME="/home/$USER"  # override home when called with sudo
# PASS="pass"
# OCLP="/home/$USER/own"
# URL="owncloud.domain.com"

# quit on first error
set -e 

sudo apt install davfs2
sudo usermod -aG davfs2 $USER

mkdir -p $OCLP
mkdir -p $HOME/.davfs2

sudo cat /etc/davfs2/secrets > $HOME/.davfs2/secrets
chmod 600 $HOME/.davfs2/secrets

# Add the following line to $HOME/.davfs2/secrets
grep $OCLP $HOME/.davfs2/secrets || printf "\n$OCLP $USER $PASS\n" >> $HOME/.davfs2/secrets

# Add the following line to /etc/fstab
grep $URL /etc/fstab || printf "\nhttps://$URL/remote.php/webdav $OCLP davfs user,rw,auto 0 0\n" >> /etc/fstab

# mount owncloud
mount $HOME/own

