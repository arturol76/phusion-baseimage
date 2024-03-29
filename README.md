# phusion-baseimage
A baseimage for dockers using phusion with SSH server enabled.

Additional features:
* nano editor
* scripts to inject ssh keys and create/export keys
* scripts to build, run

## Versions: 
* phusion 0.10.2
* phusion 0.11

## Build
Have a look to script build.sh.
Such script will build the dockerfile on the target host specified by docker_ip.

USAGE:
`./build.sh docker_ip phusion_tag`

docker_ip: ip of docker host
phusion_tag: 0.10.2 or 0.11

EXAMPLE:
To build the image based on phusion/baseimage:0.10.2
`./build.sh 192.168.2.96 0.10.2`

To build the image based on phusion/baseimage:0.11
`./build.sh 192.168.2.96 0.11`

## Run
Have a look to script run.sh.
Such script will run image "arturol76/phusion-baseimage" on the target "docker-ip" host.
Container name is specified by "container_name".
Container will expose SSH service on port "docker_port".

NOTE: it will create and mount a named volume for the persistent storage of .ssh files.

USAGE:
`./run.sh docker_ip container_name docker_port`

EXAMPLE:
`./run.sh 192.168.2.96 phusion-baseimage-test 6022`

NOTE: 
* change "port" to match the SSH port of the container
* change "remotePath" to match the target folder

## SSH Keys
Have a look to the [keys](./keys).
IMPORTANT: the container must be running.

## Change Log
2019-09-22
- 1st version.