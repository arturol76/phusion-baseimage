#!/bin/bash
echo ------------------------------------------------------
echo Creates SSH key pair on the target machine, adds the pub key
echo to authorized_keys and exports the pair to the local machine
echo USAGE:
echo ./keys-create.sh docker_ip container_name key_filename key_passphrase key_comment 
echo
echo example:
echo    ./keys-create.sh 192.168.2.96 phusion-baseimage-test art_keyfile "password" "art key"
echo ------------------------------------------------------
echo

docker_host=$1
docker_name=$2
key_filename=$3
key_passphrase=$4
key_comment=$5

echo creating volumes...
volume_ssh=${docker_name}_ssh
docker -H $docker_host volume create ${volume_ssh}

echo creating key pair...
docker -H $docker_host exec -it $docker_name ssh-keygen -b 2048 -t rsa -C $key_comment -f /tmp/$key_filename -N $key_passphrase

echo adding pub key to authorized_keys...
docker -H $docker_host exec -it $docker_name /bin/sh -c "cat /tmp/${key_filename}.pub >> /root/.ssh/authorized_keys"

echo exporting key pair to local system...
docker -H $docker_host cp $docker_name:/tmp/$key_filename ./keys
docker -H $docker_host cp $docker_name:/tmp/${key_filename}.pub ./keys

echo removing keys...
docker -H $docker_host exec -it $docker_name rm -f /tmp/$key_filename
docker -H $docker_host exec -it $docker_name rm -f /tmp/${key_filename}.pub
