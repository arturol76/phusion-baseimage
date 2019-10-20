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
Scripts to create a new SSH key pair or to use an existing one are provided in folder ./keys.

### Create a key pair
To create a new key pair (and automatically add the pub key to the docker's authorized_keys and to export the pair to the local machine):

```
./keys-create.sh docker_ip container_name key_filename key_passphrase key_comment
```

EXAMPLE:
```
./keys-create.sh 192.168.2.96 phusion-baseimage-test art_keyfile mypassword "this is my key"
```

The script will export the key pair (pub/private) to the local machine. The key pair can be then imported into [pageant](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) for authentication into the docker.

### Import existing key pair
To import an existing key (and automatically add it to the docker's authorized_keys):

```
./keys-inject.sh docker_ip container_name pub_key_to_import
```

EXAMPLE:
```
./keys-inject.sh 192.168.2.96 phusion-baseimage-test art.pub
```

Note that only the pub key is needed.

## Change Log
2019-09-22
- 1st version.