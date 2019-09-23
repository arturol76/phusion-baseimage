#!/bin/bash
show_help()
{
	echo ------------------------------------------------------
	echo Adds the given pub key to the the target machine''s authorized_keys
	echo
    echo USAGE:
	echo ./keys-inject.sh docker_ip container_name pub_key_to_import
	echo
	echo EXAMPLE:
	echo ./keys-inject.sh 192.168.2.96 phusion-baseimage-test art.pub
	echo ------------------------------------------------------
	echo
}

num_of_params=3
docker_host=$1
docker_name=$2
key_filename=$3

#checks number of parameters
if [ "$#" -ne $num_of_params ]; then
    echo "Illegal number of parameters."
    echo
    show_help
    exit 1
fi



echo creating volumes...
volume_ssh=${docker_name}_ssh
docker -H $docker_host volume create ${volume_ssh}

read -p "Do you want to inject ssh keys? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo copying SSH keys...
        
    docker -H $docker_host cp ./keys/$key_filename $docker_name:/tmp
    docker -H $docker_host exec -it $docker_name /bin/sh -c "cat /tmp/$key_filename >> /root/.ssh/authorized_keys"
    docker -H $docker_host exec -it $docker_name rm -f /tmp/$key_filename
else 
    echo
fi

exit 0