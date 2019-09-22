#!/bin/bash
echo ------------------------------------------------------
echo USAGE:
echo ./run.sh docker_ip container_name docker_port
echo
echo example:
echo    ./run.sh 192.168.2.96 phusion-baseimage-test 6022
echo ------------------------------------------------------
echo

#EDIT TO YOUR NEEDS--------------------
docker_image=arturol76/phusion-baseimage
#--------------------------------------

docker_host=$1
docker_name=$2
docker_port=$3

echo creating volumes...
volume_ssh=${docker_name}_ssh
docker -H $docker_host volume create ${volume_ssh}

#if docker is already running, stops it
if [ "$(docker -H $docker_host ps -a | grep $docker_name)" ]; then
    echo container $docker_host already exists

    echo stopping it...
    docker -H $docker_host stop $docker_name

    echo removing it...
    docker -H $docker_host rm $docker_name
fi

# create your container
echo creating the container...
docker -H $docker_host create \
    --restart always \
    -p ${docker_port}:22/tcp \
    -e TZ="Europe/Rome" \
    -v ${volume_ssh}:"/root/.ssh":rw \
    --name $docker_name \
    $docker_image

#run
echo starting the container...
docker -H $docker_host start \
    $docker_name